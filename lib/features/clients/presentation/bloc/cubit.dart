import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/features/clients/domain/usecases/accept_booking_use_case.dart';
import 'package:manicann/features/clients/domain/usecases/decline_booking_use_case.dart';
import 'package:manicann/features/clients/domain/usecases/get_booking_percentage_use_case.dart';
import 'package:manicann/features/clients/domain/usecases/get_current_client_bookings_use_case.dart';
import 'package:manicann/features/clients/presentation/bloc/states.dart';
import 'package:manicann/models.dart';
import '../../../../core/constance/appLink.dart';
import '../../../../core/constance/constance.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/client.dart';
import '../../domain/entities/client_booking_percentage.dart';
import '../../domain/usecases/add_employee_use_case.dart';
import '../../domain/usecases/delete_employee_use_case.dart';
import '../../domain/usecases/edit_employee_use_case.dart';
import '../../domain/usecases/get_all_employees_use_case.dart';
import '../../domain/usecases/get_archived_client_bookings_use_case.dart';

class ClientsCubit extends Cubit<ClientsStates> {
  ClientsCubit({
    required this.getAllClientsUseCase,
    required this.addClientUseCase,
    required this.deleteClientUseCase,
    required this.editClientUseCase,
    required this.getCurrentClientBookingsUseCase,
    required this.acceptBookingUseCase,
    required this.declineBookingUseCase,
    required this.getArchivedClientBookingsUseCase,
    required this.getBookingPercentageUseCase,
  }) : super(ClientsInitialState()) {
    isBuiled = true;
  }
  static ClientsCubit get(context) => BlocProvider.of(context);
  bool isBuiled = false;
  List<Client> allClientsList = [];
  List<Client> clientsList = [];

  // Drop Down Section

  void invalidFieldErrorTrigger() {
    emit(AddClientClienttyFieldsWarningState(
        error: "هنالك خلل في البيانات المدخلةً"));
  }

  void sortList(String? type) {
    if (type == null) {
      return;
    } else {
      clientsList.sort((a, b) {
        if (a.firstName != null &&
            a.lastName != null &&
            b.firstName != null &&
            b.lastName != null) {
          final int firstNameComparison =
              b.firstName?.compareTo(a.firstName!) ?? 0;
          if (firstNameComparison != 0) {
            return firstNameComparison;
          }
          return b.lastName?.compareTo(a.lastName!) ?? 0;
        }
        return 0;
      });
    }
    changeClientTablePage(1);
  }

  // Search Section
  void searchInList(String? text) {
    final List<Client> filteredList = [];
    if (text == null || text == "") {
      clientsList = allClientsList;
    } else {
      for (final client in allClientsList) {
        if (client.firstName!.toLowerCase().startsWith(text.toLowerCase()) ||
            client.lastName!.toLowerCase().startsWith(text.toLowerCase())) {
          filteredList.add(client);
        }
      }
      clientsList = filteredList;
    }
    clientsTablePageIndex = 1;
    emit(ClientsTableSearchState());
  }

  // Table Section
  int clientsTablePageIndex = 1;
  void changeClientTablePage(int page) {
    clientsTablePageIndex = page;
    emit(ClientsTableChangingPageState());
  }

  Uint8List? imageBytes;
  PlatformFile? imageFile;
  void addClientProfilePicture() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        imageFile = result.files.first;
        imageBytes = imageFile!.bytes!;
      }
      emit(ClientsAddProfilePictureSuccessState());
    } catch (e) {
      emit(ClientsAddProfilePictureErrorState());
    }
  }

  // UseCase Calls Section
  // CRUD
  final GetAllClientsUseCase getAllClientsUseCase;
  void getAllClients(int branchId) async {
    emit(GetClientsLoadingState());
    final failureOrClients = await getAllClientsUseCase(branchId: branchId);
    failureOrClients.fold(
      (failure) {
        emit(GetClientsErrorState(error: _mapFailureToString(failure)));
      },
      (clients) {
        clientsList = clients;
        allClientsList = clients;
        sortList("أبجدياً");
        emit(GetClientsSuccessState());
      },
    );
  }

  final DeleteClientUseCase deleteClientUseCase;
  void deleteClient({required int clientId}) async {
    emit(DeleteClientLoadingState());
    final failureOrUnit = await deleteClientUseCase(clientId: clientId);
    failureOrUnit.fold(
      (failure) {
        emit(DeleteClientErrorState(error: _mapFailureToString(failure)));
      },
      (unit) {
        getAllClients(int.parse(AppLink.branchId));
        emit(DeleteClientSuccessState());
      },
    );
  }

  final AddClientUseCase addClientUseCase;
  void addClient({
    required String firstName,
    required String middleName,
    required String lastName,
    required String phoneNumber,
  }) async {
    emit(AddClientLoadingState());
    final failureOrUnit = await addClientUseCase(
      client: Client(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        branchId: int.parse(AppLink.branchId),
      ),
      image: imageFile,
    );
    failureOrUnit.fold(
      (failure) {
        emit(AddClientErrorState(error: _mapFailureToString(failure)));
      },
      (unit) {
        imageBytes = null;
        imageFile = null;
        getAllClients(int.parse(AppLink.branchId));
        emit(AddClientSuccessState());
      },
    );
  }

  //edit
  Client? selectedClientToEdit;
  selectClientToEdit({required Client client}) {
    selectedClientToEdit = Client(
      id: client.id,
      firstName: client.firstName,
      middleName: client.middleName,
      lastName: client.lastName,
      phoneNumber: client.phoneNumber,
      branchId: client.branchId,
      email: client.email,
      image: client.image != null
          ? ImageModel(
              id: client.image!.id,
              imageableType: client.image!.imageableType,
              imageableId: client.image!.imageableId,
              image: client.image!.image,
              type: client.image!.type,
            )
          : null,
    );
    emit(ClientToEditSelectionState());
  }

  Uint8List? editImageBytes;
  PlatformFile? editImageFile;
  void editClientProfilePicture() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        editImageFile = result.files.first;
        editImageBytes = editImageFile!.bytes!;
      }
      emit(ClientsEditProfilePictureSuccessState());
    } catch (e) {
      emit(ClientsEditProfilePictureErrorState());
    }
  }

  EditClientUseCase editClientUseCase;
  void editClient({
    required String? firstName,
    required String? middleName,
    required String? lastName,
    required String? phoneNumber,
  }) async {
    bool nothingChanged = true;
    if (true) {
      if (firstName == selectedClientToEdit!.firstName) {
        firstName = null;
      } else {
        nothingChanged = false;
      }
      if (middleName == selectedClientToEdit!.middleName) {
        middleName = null;
      } else {
        nothingChanged = false;
      }
      if (lastName == selectedClientToEdit!.lastName) {
        lastName = null;
      } else {
        nothingChanged = false;
      }
      if (phoneNumber == selectedClientToEdit!.phoneNumber) {
        phoneNumber = null;
      } else {
        nothingChanged = false;
      }
      if (editImageBytes != null) nothingChanged = false;
    }
    if (nothingChanged) {
      emit(EditClientNothingChangedState());
      return;
    } else {
      emit(EditClientLoadingState());
      final failureOrUnit = await editClientUseCase(
        client: Client(
          id: selectedClientToEdit!.id,
          firstName: firstName,
          middleName: middleName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          branchId: int.parse(AppLink.branchId),
        ),
        image: editImageFile,
      );
      failureOrUnit.fold(
        (failure) {
          emit(EditClientErrorState(error: _mapFailureToString(failure)));
        },
        (unit) {
          editImageBytes = null;
          editImageFile = null;
          getAllClients(int.parse(AppLink.branchId));
          emit(EditClientSuccessState());
        },
      );
    }
  }

  // Details
  Client? detailsClient;
  void selectClientToShowDetails({required Client client}) {
    detailsClient = client;
    emit(ClientToShowDetailsSelectionState());
  }

  BookingPercentage? bookingPercentage;
  GetBookingPercentageUseCase getBookingPercentageUseCase;
  void getBookingPercentage(int clientId) async {
    emit(GetBookingPercentageLoadingState());
    final failureOrPercentage =
        await getBookingPercentageUseCase(clientId: clientId);
    failureOrPercentage.fold(
      (failure) {
        emit(GetBookingPercentageErrorState(
            error: _mapFailureToString(failure)));
      },
      (percentage) {
        bookingPercentage = percentage;
        emit(GetBookingPercentageSuccessState());
      },
    );
  }

  //CurrentBookings
  List<Booking> clientCurrentBookings = [];

  int currentBookingsPageIndex = 1;
  void changeCurrentBookingsPage(int page) {
    clientsTablePageIndex = page;
    emit(ClientsTableChangingPageState());
  }

  GetCurrentClientBookingsUseCase getCurrentClientBookingsUseCase;
  void getClientCurrentBookings(int clientId) async {
    emit(GetClientCurrentBookingsLoadingState());
    final failureOrBookings =
        await getCurrentClientBookingsUseCase(clientId: clientId);
    failureOrBookings.fold(
      (failure) {
        emit(GetClientCurrentBookingsErrorState(
            error: _mapFailureToString(failure)));
      },
      (bookings) {
        clientCurrentBookings = bookings;
        emit(GetClientCurrentBookingsSuccessState());
      },
    );
  }

  AcceptBookingUseCase acceptBookingUseCase;
  void submitBooking(int id) async {
    emit(AcceptBookingLoadingState());
    final failureOrUnit = await acceptBookingUseCase(bookingId: id);
    failureOrUnit.fold(
      (failure) {
        emit(AcceptBookingErrorState(error: _mapFailureToString(failure)));
      },
      (unit) {
        getClientCurrentBookings(detailsClient!.id!);
        emit(AcceptBookingSuccessState());
      },
    );
  }

  DeclineBookingUseCase declineBookingUseCase;
  void declineBooking(int id) async {
    emit(DeclineBookingLoadingState());
    final failureOrUnit = await declineBookingUseCase(bookingId: id);
    failureOrUnit.fold(
      (failure) {
        emit(DeclineBookingErrorState(error: _mapFailureToString(failure)));
      },
      (unit) {
        getClientCurrentBookings(detailsClient!.id!);
        emit(DeclineBookingSuccessState());
      },
    );
  }

  //ArchivedBookings
  List<Booking> clientArchivedBookings = [];

  int archivedBookingsPageIndex = 1;
  void changeArchivedBookingsPage(int page) {
    clientsTablePageIndex = page;
    emit(ClientsTableChangingPageState());
  }

  GetArchivedClientBookingsUseCase getArchivedClientBookingsUseCase;
  void getClientArchivedBookings(int clientId) async {
    emit(GetClientArchivedBookingsLoadingState());
    final failureOrBookings =
        await getArchivedClientBookingsUseCase(clientId: clientId);
    failureOrBookings.fold(
      (failure) {
        emit(GetClientArchivedBookingsErrorState(
            error: _mapFailureToString(failure)));
      },
      (bookings) {
        clientArchivedBookings = bookings;
        emit(GetClientArchivedBookingsSuccessState());
      },
    );
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
