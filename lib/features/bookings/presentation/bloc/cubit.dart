import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/function/error_message.dart';
import 'package:manicann/features/bookings/domain/usecases/download_file_bookings_use_case.dart';
import 'package:manicann/features/bookings/domain/usecases/get_all_current_bookings_use_case.dart';
import 'package:manicann/features/bookings/presentation/bloc/states.dart';
import 'package:manicann/features/employees/data/models/file_employee_model.dart';
import 'package:manicann/features/employees/domain/entities/file_attendance.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constance/constance.dart';
import '../../../../core/error/failures.dart';
import '../../../clients/domain/entities/booking.dart';
import '../../../clients/domain/usecases/accept_booking_use_case.dart';
import '../../../clients/domain/usecases/decline_booking_use_case.dart';
import '../../domain/usecases/get_all_archived_bookings.dart';

class BookingsCubit extends Cubit<BookingsStates> {
  BookingsCubit({
    required this.acceptBookingUseCase,
    required this.fileBookingsUseCase,
    required this.declineBookingUseCase,
    required this.getAllCurrentBookingsUseCase,
    required this.getAllArchivedBookingsUseCase,
  }) : super(BookingsInitialState()) {
    isBuiled = true;
  }
  static BookingsCubit get(context) => BlocProvider.of(context);
  bool isBuiled = false;
  // Current Bookings
  List<Booking> allCurrentBookingsList = [];
  List<Booking> currentBookingsList = [];

  // Drop Down Section
  List<DropdownMenuItem<Text>> currentBookingListFilterTypes = [
    const DropdownMenuItem<Text>(
      value: Text("الكل"),
      child: Text("الكل"),
    ),
    const DropdownMenuItem<Text>(
      value: Text("مثبت"),
      child: Text("مثبت"),
    ),
    const DropdownMenuItem<Text>(
      value: Text("ملغي"),
      child: Text("ملغي"),
    ),
    const DropdownMenuItem<Text>(
      value: Text("قيد الانتظار"),
      child: Text("قيد الانتظار"),
    ),
  ];

  Text? currentBookingsTableFilterType;
  void changeCurrentBookingsTableFilter(Text? text) {
    currentBookingsTableFilterType = text;
    if (text != null) sortList(text.data);
    emit(CurrentBookingsTableChangingFilterState());
  }

  void sortList(String? type) {
    List<Booking> tmp = [];
    if (type == null) {
      return;
    } else if (type.toLowerCase() == "الكل") {
      tmp = allCurrentBookingsList;
    } else if (type.toLowerCase() == "مثبت") {
      for (var booking in allCurrentBookingsList) {
        if (booking.status?.toLowerCase() == "done") tmp.add(booking);
      }
    } else if (type.toLowerCase() == "قيد الانتظار") {
      for (var booking in allCurrentBookingsList) {
        if (booking.status?.toLowerCase() == "waiting") tmp.add(booking);
      }
    } else if (type.toLowerCase() == "ملغي") {
      for (var booking in allCurrentBookingsList) {
        if (booking.status?.toLowerCase() == "declined") tmp.add(booking);
      }
    } else {
      return;
    }
    currentBookingsList = tmp;
    changeCurrentBookingTablePage(1);
  }

  // Search Section
  void searchCurrentInList(String? text) {
    final List<Booking> filteredList = [];
    if (text == null || text == "") {
      currentBookingsList = allCurrentBookingsList;
    } else {
      for (final booking in allCurrentBookingsList) {
        if (booking.customerFirstName!
                .toLowerCase()
                .startsWith(text.toLowerCase()) ||
            booking.customerLastName!
                .toLowerCase()
                .startsWith(text.toLowerCase()) ||
            booking.employeeFirstName!
                .toLowerCase()
                .startsWith(text.toLowerCase()) ||
            booking.employeeLastName!
                .toLowerCase()
                .startsWith(text.toLowerCase())) {
          filteredList.add(booking);
        }
      }
      currentBookingsList = filteredList;
    }
    currentBookingsTablePageIndex = 1;
    emit(CurrentBookingsTableSearchState());
  }

  // Table Section
  int currentBookingsTablePageIndex = 1;
  void changeCurrentBookingTablePage(int page) {
    currentBookingsTablePageIndex = page;
    emit(CurrentBookingsTableChangingPageState());
  }

  // UseCase Calls Section
  GetAllCurrentBookingsUseCase getAllCurrentBookingsUseCase;
  void getAllCurrentBookings(int id) async {
    emit(GetCurrentBookingsLoadingState());
    final failureOrBookings = await getAllCurrentBookingsUseCase(branchId: id);
    failureOrBookings.fold(
      (failure) {
        emit(GetCurrentBookingsErrorState(error: _mapFailureToString(failure)));
      },
      (bookings) {
        currentBookingsList = bookings;
        allCurrentBookingsList = bookings;
        emit(GetCurrentBookingsSuccessState());
      },
    );
  }

  // Archived Bookings
  List<Booking> allArchivedBookingsList = [];
  List<Booking> archivedBookingsList = [];

  // Drop Down Section
  List<DropdownMenuItem<Text>> archivedBookingListFilterTypes = [
    const DropdownMenuItem<Text>(
      value: Text("الكل"),
      child: Text("الكل"),
    ),
    const DropdownMenuItem<Text>(
      value: Text("منتهي"),
      child: Text("منتهي"),
    ),
    const DropdownMenuItem<Text>(
      value: Text("ملغي"),
      child: Text("ملغي"),
    ),
  ];

  Text? archivedBookingsTableFilterType;
  void changeArchivedBookingsTableFilter(Text? text) {
    archivedBookingsTableFilterType = text;
    if (text != null) sortArchivedList(text.data);
    emit(ArchivedBookingsTableChangingFilterState());
  }

  void sortArchivedList(String? type) {
    List<Booking> tmp = [];
    if (type == null) {
      return;
    } else if (type.toLowerCase() == "الكل") {
      tmp = allArchivedBookingsList;
    } else if (type.toLowerCase() == "منتهي") {
      for (var booking in allArchivedBookingsList) {
        if (booking.status?.toLowerCase() == "done") tmp.add(booking);
      }
    } else if (type.toLowerCase() == "ملغي") {
      for (var booking in allArchivedBookingsList) {
        if (booking.status?.toLowerCase() == "declined") tmp.add(booking);
      }
    } else {
      return;
    }
    archivedBookingsList = tmp;
    changeArchivedBookingTablePage(1);
  }

  // Search Section
  void searchInArchivedList(String? text) {
    final List<Booking> filteredList = [];
    if (text == null || text == "") {
      archivedBookingsList = allArchivedBookingsList;
    } else {
      for (final booking in allArchivedBookingsList) {
        if (booking.customerFirstName!
                .toLowerCase()
                .startsWith(text.toLowerCase()) ||
            booking.customerLastName!
                .toLowerCase()
                .startsWith(text.toLowerCase()) ||
            booking.employeeFirstName!
                .toLowerCase()
                .startsWith(text.toLowerCase()) ||
            booking.employeeLastName!
                .toLowerCase()
                .startsWith(text.toLowerCase())) {
          filteredList.add(booking);
        }
      }
      archivedBookingsList = filteredList;
    }
    archivedBookingsTablePageIndex = 1;
    emit(ArchivedBookingsTableSearchState());
  }

  // Table Section
  int archivedBookingsTablePageIndex = 1;
  void changeArchivedBookingTablePage(int page) {
    currentBookingsTablePageIndex = page;
    emit(ArchivedBookingsTableChangingPageState());
  }

  // UseCase Calls Section
  GetAllArchivedBookingsUseCase getAllArchivedBookingsUseCase;
  void getAllArchivedBookings(int id) async {
    emit(GetArchivedBookingsLoadingState());
    final failureOrBookings = await getAllArchivedBookingsUseCase(branchId: id);
    failureOrBookings.fold(
      (failure) {
        emit(
            GetArchivedBookingsErrorState(error: _mapFailureToString(failure)));
      },
      (bookings) {
        archivedBookingsList = bookings;
        allArchivedBookingsList = bookings;
        emit(GetArchivedBookingsSuccessState());
      },
    );
  }

  //Accept and Decline

  AcceptBookingUseCase acceptBookingUseCase;
  void submitBooking(int id) async {
    emit(AcceptBookingLoadingState());
    final failureOrUnit = await acceptBookingUseCase(bookingId: id);
    failureOrUnit.fold(
      (failure) {
        emit(AcceptBookingErrorState(error: _mapFailureToString(failure)));
      },
      (unit) {
        getAllCurrentBookings(int.parse(AppLink.branchId));
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
        getAllCurrentBookings(int.parse(AppLink.branchId));
        emit(DeclineBookingSuccessState());
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

  ///////////////
  DateTime? _selectedDate;
  bool validTime = false;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      validTime = true;
      emit(ReportBookingSuccessState());
    } else {
      const CustomToast(
        type: "Warning",
        msg: " الرجاء اختيار تاريخ",
      )(context);
    }
  }

  FileBookingsUseCase fileBookingsUseCase;

  getReportBooking(BuildContext context) async {
    await selectDate(context);
    if (validTime) {
      emit(ReportBookingLoadingState());
      final mapData = await fileBookingsUseCase.downloadFileBooking(
          DownloadFileEntity(
              date: DateFormat('yyyy-MM-dd').format(_selectedDate!),
              idEmployee: null));
      validTime = false;
      emit(mapFailureOrReportBookingToState(
          mapData, context, 'تم تحميل التقرير بنجاح'));
    }
  }

  BookingsStates mapFailureOrReportBookingToState(
      Either<Failure, FileResponseModel> either,
      BuildContext context,
      String msg) {
    return either.fold(
      (l) {
        return ReportBookingErrorState(error: mapFailureToMessage(l));
      },
      (r) {
        if (r.original.fileUrl != null) {
          launchURL(r.original.fileUrl!, context);
        }
        return ReportBookingSuccessState();
      },
    );
  }

  void launchURL(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Show an error message if the URL cannot be launched
        const CustomToast(
          type: "Error",
          msg: 'حدث خطأ أثناء فتح الرابط , حاول مجدداً',
        )(context);
      }
    } catch (e) {
      // Handle any exceptions that occur during the launch
      print('Error launching URL: $e');
      const CustomToast(
        type: "Error",
        msg: 'حدث خطأ أثناء فتح الرابط, حاول مجدداً',
      )(context);
    }
  }
}
