import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/core/function/error_message.dart';
import 'package:manicann/core/function/time_formatter.dart';
import 'package:manicann/features/booking/data/models/Services_employee_Model.dart';
import 'package:manicann/features/booking/data/models/available_time_model.dart';
import 'package:manicann/features/booking/data/models/users_model.dart';
import 'package:manicann/features/booking/domain/entities/booking_entity_data.dart';
import 'package:manicann/features/booking/domain/usecases/booking_usecase.dart';
import 'package:manicann/features/booking/presentation/bloc/cubit/booking_bolc_state.dart';
import 'package:manicann/features/bookings/presentation/bloc/cubit.dart';

class BookingBloc extends Cubit<BookingState> {
  late BookingUsecase bookingsUsecase;

  BookingBloc(super.initialState, {required this.bookingsUsecase}) {
    isBuiled = true;
    print('API:getServicesAndEmployee:====>fetch');
    getData();
    print('API:getServicesAndEmployee:====>done');
  }
  bool isBuiled = false;
  TextEditingController controllerNameBooking = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  List<Service> listServices = [];
  List<Employee> listEmployees = [];
  List<UserModel> listCustomers = [];
  List<AvailableTimeModel> listAvailableTime = [];
  DateTime selectedDate = DateTime.now();
  int indexSelectAvaliableTime = 0;
  bool isValid = true;
  var isSelectedService, isSelectedEmployee, isSelectedCustomer;
  String employeeId = '0', serviceId = '0', customerId = '0';
  GlobalKey<FormState>? formstate = GlobalKey<FormState>();

  getData() {
    getServicesAndEmployee();
    getAllCustomer();
  }

  changeServiceVlaueDropDown(val) async {
    if (val != isSelectedService) {
      isSelectedService = val.name;
      listEmployees = val.employees;
      serviceId = val.id.toString();
      if (listEmployees.isNotEmpty) {
        isSelectedEmployee =
            "${listEmployees[0].firstName}  ${listEmployees[0].firstName}";
        employeeId = listEmployees[0].id.toString();
      } else {
        isSelectedEmployee = 'لا يوجد موظفين';
        employeeId = '0';
      }
      getAvaliableTime();
      emit((SuccessBookingState()));
    }
  }

  changeEmployeeVlaueDropDown(val) async {
    if (val != isSelectedEmployee) {
      isSelectedEmployee = val.firstName + "  " + val.lastName;
      employeeId = val.id.toString();
      emit((SuccessBookingState()));
    }
  }

  changeCustomerVlaueDropDown(val) async {
    if (val != isSelectedCustomer) {
      isSelectedCustomer = val.firstName + "  " + val.lastName;
      customerId = val.id.toString();
      print(customerId);
      print('customerId....................');
      emit((SuccessBookingState()));
    }
  }

  selectAvaliableTime(int index) {
    indexSelectAvaliableTime = index;
    emit((SuccessBookingState()));
  }

  void getServicesAndEmployee() async {
    emit(LoadingBookingState());
    final mapData = await bookingsUsecase.getAllServiceAndEmployee();
    emit(mapFailureOrServiceAndEmployeeToState(mapData));
  }

  void getAvaliableTime() async {
    print("Loading..............");
    emit(LoadingBookingState());
    final mapData = await bookingsUsecase.getAvailableTime(
        serviceId, DateFormat('yyyy-MM-dd').format(selectedDate));
    emit(mapFailureOrAvailableTimeToState(mapData));
  }

  void getAllCustomer() async {
    emit(LoadingBookingState());
    final mapData = await bookingsUsecase.getAllUsers();
    emit(mapFailureOrCustomerToState(mapData));
  }

  void addBooking(int? idCustomer, BuildContext context) async {
    print('customerIdcustomerIdcustomerId $idCustomer');
    if (serviceId == '0') {
      const CustomToast(type: "Warning", msg: 'الرجاء اختيار الخدمة')(context);
      return;
    }
    if (employeeId == '0') {
      const CustomToast(type: "Warning", msg: 'الرجاء اختيار الموظف')(context);
      return;
    }
    if (customerId == '0' && idCustomer == null) {
      const CustomToast(type: "Warning", msg: 'الرجاء اختيار الزبون')(context);
      return;
    }
    if (listAvailableTime.isEmpty) {
      const CustomToast(
              type: "Warning",
              msg: 'لايوجد أوقات متاحة في هذا اليوم , الرجاء اختيار يوم اخر')(
          context);
      return;
    }
    if (formstate!.currentState!.validate()) {
      isValid = true;
      BookingEntity bookingEntityData;
      if (customerId != '0') {
        bookingEntityData = bookingEntity(customerId);
      } else {
        bookingEntityData = bookingEntity(idCustomer.toString());
      }
      emit(LoadingBookingState());
      final mapData = await bookingsUsecase.addBooking(bookingEntityData);
      // ignore: use_build_context_synchronously
      emit(mapFailureOrAddBookingToState(mapData, context));
    } else {
      isValid = false;
      emit(SuccessBookingState());
    }
  }

  BookingEntity bookingEntity(String idCustomer) {
    print(idCustomer);
    print('[[[[[[[[[]]]]]]]]]');
    return BookingEntity(
        userId: idCustomer,
        operationId: serviceId,
        employeeId: employeeId,
        date: DateFormat('yyyy-MM-dd').format(selectedDate),
        time: convertTimeFormatForBackEnd(formatArabicTime(
            "${listAvailableTime[indexSelectAvaliableTime].from}:00")));
  }

  BookingState mapFailureOrAddBookingToState(
      Either<Failure, Unit> either, context) {
    return either.fold(
      (l) => ErrorBookingState(message: mapFailureToMessage(l)),
      (r) {
        BookingsCubit bookingsCubit = BlocProvider.of<BookingsCubit>(context);
        if (bookingsCubit.isBuiled) {
          bookingsCubit.getAllCurrentBookings(int.parse(AppLink.branchId));
        }
        const CustomToast(type: "Success", msg: "تم إضافة الحجز بنجاح")(
            context);
        return SuccessBookingState();
      },
    );
  }

  BookingState mapFailureOrServiceAndEmployeeToState(
      Either<Failure, ServiceEmployeeModel> either) {
    return either.fold(
      (l) => ErrorBookingState(message: mapFailureToMessage(l)),
      (r) {
        listServices = r.services;
        if (listServices.isNotEmpty) {
          listEmployees = listServices[0].employees;
          isSelectedService = listServices[0].name;
          serviceId = listServices[0].id.toString();
          getAvaliableTime();
          if (listEmployees.isNotEmpty) {
            isSelectedEmployee =
                listEmployees[0].firstName + listEmployees[0].firstName;
            employeeId = listEmployees[0].id.toString();
          } else {
            isSelectedEmployee = 'لا يوجد موظفين';
            employeeId = '0';
          }
        }
        return SuccessBookingState();
      },
    );
  }

  BookingState mapFailureOrAvailableTimeToState(
      Either<Failure, List<AvailableTimeModel>> either) {
    return either.fold(
      (l) => ErrorBookingState(message: mapFailureToMessage(l)),
      (r) {
        listAvailableTime = r;

        return SuccessBookingState();
      },
    );
  }

  BookingState mapFailureOrCustomerToState(
      Either<Failure, List<UserModel>> either) {
    return either.fold(
      (l) => ErrorBookingState(message: mapFailureToMessage(l)),
      (r) {
        listCustomers = r;
        if (listCustomers.isNotEmpty) {
          isSelectedCustomer =
              listCustomers[0].firstName + listCustomers[0].firstName;
          customerId = listCustomers[0].id.toString();
        }
        return SuccessBookingState();
      },
    );
  }
}
