import 'package:manicann/features/Branches/data/repositories/Branches_repository_impl.dart';
import 'package:manicann/features/authentication/data/datasources/user_local_data_source.dart';
import 'package:manicann/features/authentication/data/datasources/user_remote_data_source.dart';
import 'package:manicann/features/authentication/data/repositories/user_repository_impl.dart';
import 'package:manicann/features/authentication/domain/repositories/user_repository.dart';
import 'package:manicann/features/authentication/domain/usecases/login_usecase.dart';
import 'package:manicann/features/authentication/presentation/bloc/cubit.dart';
import 'package:manicann/features/before_after/data/datasources/before_after_remote_data_source.dart';
import 'package:manicann/features/before_after/data/repositories/before_after_repository_impl.dart';
import 'package:manicann/features/before_after/domain/usecases/before_after_usecase.dart';
import 'package:manicann/features/before_after/presentation/bloc/cubit/before_after_cubit.dart';
import 'package:manicann/features/before_after/presentation/bloc/cubit/before_after_state.dart';
import 'package:manicann/features/booking/domain/usecases/booking_usecase.dart';
import 'package:manicann/features/booking/presentation/bloc/cubit/booking_bolc_cubit.dart';
import 'package:manicann/features/booking/presentation/bloc/cubit/booking_bolc_state.dart';
import 'package:manicann/features/bookings/data/datasources/booking_remote_data_source.dart';
import 'package:manicann/features/bookings/data/repositories/booking_repositroy_impl.dart';
import 'package:manicann/features/bookings/domain/usecases/accept_booking_use_case.dart';
import 'package:manicann/features/bookings/domain/usecases/decline_booking_use_case.dart';
import 'package:manicann/features/bookings/domain/usecases/get_all_archived_bookings.dart';
import 'package:manicann/features/bookings/domain/usecases/get_all_current_bookings_use_case.dart';
import 'package:manicann/features/bookings/domain/usecases/download_file_bookings_use_case.dart';
import 'package:manicann/features/bookings/presentation/bloc/cubit.dart';
import 'package:manicann/features/branches/data/datasources/branch_remote_data_source.dart';
import 'package:manicann/features/branches/domain/usecases/branches_usecase.dart';
import 'package:manicann/features/branches/presentation/bloc/branches_bloc/branches_bloc.dart';
import 'package:manicann/features/branches/presentation/bloc/branches_bloc/branches_state.dart';
import 'package:manicann/features/clients/data/datasources/client_remote_data_source.dart';
import 'package:manicann/features/clients/data/repositories/client_repositroy_impl.dart';
import 'package:manicann/features/clients/domain/repositories/clients_repository.dart';
import 'package:manicann/features/clients/domain/usecases/accept_booking_use_case.dart';
import 'package:manicann/features/clients/domain/usecases/add_employee_use_case.dart';
import 'package:manicann/features/clients/domain/usecases/decline_booking_use_case.dart';
import 'package:manicann/features/clients/domain/usecases/delete_employee_use_case.dart';
import 'package:manicann/features/clients/domain/usecases/edit_employee_use_case.dart';
import 'package:manicann/features/clients/domain/usecases/get_all_employees_use_case.dart';
import 'package:manicann/features/clients/domain/usecases/get_archived_client_bookings_use_case.dart';
import 'package:manicann/features/clients/domain/usecases/get_booking_percentage_use_case.dart';
import 'package:manicann/features/clients/domain/usecases/get_current_client_bookings_use_case.dart';
import 'package:manicann/features/clients/presentation/bloc/cubit.dart';
import 'package:manicann/features/complaints/data/datasources/complaints_remote_data_source.dart';
import 'package:manicann/features/complaints/data/repositories/complaint_repository_impl.dart';
import 'package:manicann/features/complaints/domain/repositories/complaints_repository.dart';
import 'package:manicann/features/complaints/domain/usecases/delete_complaint.dart';
import 'package:manicann/features/complaints/domain/usecases/get_all_complaints.dart';
import 'package:manicann/features/complaints/presentation/bloc/cubit.dart';
import 'package:manicann/features/employees/data/datasources/employee_remote_data_source.dart';
import 'package:manicann/features/employees/data/repositories/employee_repository_impl.dart';
import 'package:manicann/features/employees/domain/repositories/employee_repository.dart';
import 'package:manicann/features/employees/domain/usecases/add_employee_use_case.dart';
import 'package:manicann/features/employees/domain/usecases/delete_employee_use_case.dart';
import 'package:manicann/features/employees/domain/usecases/edit_employee_use_case.dart';
import 'package:manicann/features/employees/domain/usecases/get_all_employees_use_case.dart';
import 'package:manicann/features/employees/domain/usecases/get_all_services_use_case.dart';
import 'package:manicann/features/employees/domain/usecases/get_employee_attendance_use_case.dart';
import 'package:manicann/features/employees/domain/usecases/upload_file_attendance_use_case.dart';
import 'package:manicann/features/employees/presentation/bloc/cubit.dart';
import 'package:manicann/features/offers/data/datasources/offer_remote_data_source.dart';
import 'package:manicann/features/offers/data/repositories/offers_repository_impl.dart';
import 'package:manicann/features/offers/domain/usecases/offers_usecase.dart';
import 'package:manicann/features/offers/presentation/bloc/offer_bloc/offer_bloc.dart';
import 'package:manicann/features/offers/presentation/bloc/offer_bloc/offer_state.dart';
import 'package:manicann/features/services/data/datasources/services_remote_data_source.dart';
import 'package:manicann/features/services/data/repositories/services_repository_impl.dart';
import 'package:manicann/features/services/domain/usecases/services_usecase.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_cubit.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_state.dart';
import 'package:manicann/features/statistic/data/datasources/statistics_remote_data_source.dart';
import 'package:manicann/features/statistic/data/repositories/statistics_repository_impl.dart';
import 'package:manicann/features/statistic/domain/usecases/statistics_usecase.dart';
import 'package:manicann/features/statistic/presentation/bloc/statistic_bloc/statistic_bloc.dart';
import 'package:manicann/features/statistic/presentation/bloc/statistic_bloc/statistic_state.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../features/Booking/data/datasources/Booking_remote_data_source.dart';
import '../features/booking/data/repositories/booking_repository_impl.dart';
import '../features/bookings/domain/repositories/booking_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Bloc
  sl.registerFactory<LoginCubit>(() => LoginCubit(loginUseCase: sl()));
  sl.registerFactory(() => ClientsCubit(
        getAllClientsUseCase: sl(),
        addClientUseCase: sl(),
        deleteClientUseCase: sl(),
        editClientUseCase: sl(),
        getBookingPercentageUseCase: sl(),
        getCurrentClientBookingsUseCase: sl(),
        acceptBookingUseCase: sl(),
        declineBookingUseCase: sl(),
        getArchivedClientBookingsUseCase: sl(),
      ));
  sl.registerFactory(() => BookingsCubit(
        fileBookingsUseCase: sl(),
        getAllCurrentBookingsUseCase: sl(),
        acceptBookingUseCase: sl(),
        declineBookingUseCase: sl(),
        getAllArchivedBookingsUseCase: sl(),
      ));

  sl.registerFactory(() => EmployeesCubit(
        fileEmployeeAttendanceUseCase: sl(),
        getAllEmployeesUseCase: sl(),
        getAllServicesUseCase: sl(),
        addEmployeeUseCase: sl(),
        deleteEmployeeUseCase: sl(),
        editEmployeeUseCase: sl(),
        getEmployeeAttendanceUseCase: sl(),
      ));
  sl.registerFactory(() =>
      BookingBloc(BookingInitial(), bookingsUsecase: sl<BookingUsecase>()));
  sl.registerFactory(() => StatisticBloc(StatisticInitial(),
      statisticsUsecase: sl<StatisticsUsecase>()));
  sl.registerFactory(() =>
      ServiceBloc(ServiceInitial(), servicesUsecase: sl<ServicesUsecase>()));
  sl.registerFactory(() => BeforeAfterBloc(BeforeAfterInitial(),
      beforeAfterUsecase: sl<BeforeAfterUsecase>()));
  sl.registerFactory(
      () => OffersBloc(OfferInitial(), offersUsecase: sl<OffersUsecase>()));
  sl.registerFactory(() => BranchesBloc(BranchesStateInitial(),
      sharedPreferences: sl<SharedPreferences>(),
      branchesUsecase: sl<BranchesUsecase>()));
  sl.registerFactory(() => ComplaintsCubit(
      getAllComplaintsUseCase: sl(), hideComplaintUseCase: sl()));
// Usecases
  sl.registerFactory(
      () => BookingUsecase(repository: sl<BookingRepositoryImpl>()));
  sl.registerFactory(
      () => StatisticsUsecase(repository: sl<StatisticsRepositoryImpl>()));
  sl.registerFactory(
      () => ServicesUsecase(repository: sl<ServicesRepositoryImpl>()));
  sl.registerFactory(
      () => BeforeAfterUsecase(repository: sl<BeforeAfterRepositoryImpl>()));
  sl.registerFactory(
      () => OffersUsecase(repository: sl<OffersRepositoryImpl>()));
  sl.registerFactory(
      () => BranchesUsecase(repository: sl<BranchesRepositoryImpl>()));
  //login
  sl.registerFactory(() => LoginUseCase(repository: sl()));
  //Bookings
  sl.registerLazySingleton(
      () => GetAllCurrentBookingsUseCase(repository: sl()));
  sl.registerLazySingleton(() => FileBookingsUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetAllArchivedBookingsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AcceptBranchBookingUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeclineBranchBookingUseCase(repository: sl()));
  //Clients
  sl.registerLazySingleton(() => GetAllClientsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddClientUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteClientUseCase(repository: sl()));
  sl.registerLazySingleton(() => EditClientUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetBookingPercentageUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetCurrentClientBookingsUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetArchivedClientBookingsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AcceptBookingUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeclineBookingUseCase(repository: sl()));

  //Employees
  sl.registerFactory(() => GetAllEmployeesUseCase(repository: sl()));
  sl.registerFactory(() => GetAllServicesUseCase(repository: sl()));
  sl.registerFactory(() => AddEmployeeUseCase(repository: sl()));
  sl.registerFactory(() => DeleteEmployeeUseCase(repository: sl()));
  sl.registerFactory(() => EditEmployeeUseCase(repository: sl()));
  sl.registerFactory(() => FileEmployeeAttendanceUseCase(repository: sl()));
  sl.registerFactory(() => GetEmployeeAttendanceUseCase(repository: sl()));

  //Complaints
  sl.registerFactory(() => GetAllComplaintsUseCase(repository: sl()));
  sl.registerFactory(() => HideComplaintUseCase(repository: sl()));
// Repository
  sl.registerFactory<EmployeeRepository>(() => EmployeeRepositoryImpl(
        remoteDataSource: sl(),
      ));
  sl.registerFactory<BookingRepositoryImpl>(() => BookingRepositoryImpl(
      remoteDataSource: sl<BookingRemoteDataSourceImpl>()));
  sl.registerFactory<StatisticsRepositoryImpl>(() => StatisticsRepositoryImpl(
      remoteDataSource: sl<StatisticRemoteDataSourceImpl>()));
  sl.registerFactory<ServicesRepositoryImpl>(() => ServicesRepositoryImpl(
      remoteDataSource: sl<ServiceRemoteDataSourceImpl>()));
  sl.registerFactory<BeforeAfterRepositoryImpl>(() => BeforeAfterRepositoryImpl(
      remoteDataSource: sl<BeforeAfterRemoteDataSourceImpl>()));
  sl.registerFactory<OffersRepositoryImpl>(() =>
      OffersRepositoryImpl(remoteDataSource: sl<OfferRemoteDataSourceImpl>()));
  sl.registerFactory<BranchesRepositoryImpl>(() => BranchesRepositoryImpl(
      remoteDataSource: sl<BranchesRemoteDataSourceImpl>()));
  sl.registerFactory<UserRepository>(() => UserRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ));
  sl.registerLazySingleton<BookingsRepository>(() => BookingsRepositoryImpl(
        remoteDataSource: sl(),
      ));
  sl.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl(
        remoteDataSource: sl(),
      ));
  sl.registerFactory<ComplaintRepository>(() => ComplaintRepositoryImpl(
        remoteDataSource: sl(),
      ));
// Datasources
  sl.registerFactory<EmployeeRemoteDataSource>(
      () => EmployeeRemoteDataSourceImpl(client: sl()));
  sl.registerFactory<BookingRemoteDataSourceImpl>(
      () => BookingRemoteDataSourceImpl(client: sl()));
  sl.registerFactory<StatisticRemoteDataSourceImpl>(
      () => StatisticRemoteDataSourceImpl(client: sl()));
  sl.registerFactory<ServiceRemoteDataSourceImpl>(
      () => ServiceRemoteDataSourceImpl(client: sl()));
  sl.registerFactory<BeforeAfterRemoteDataSourceImpl>(
      () => BeforeAfterRemoteDataSourceImpl(client: sl()));
  sl.registerFactory<OfferRemoteDataSourceImpl>(
      () => OfferRemoteDataSourceImpl(client: sl()));
  sl.registerFactory<BranchesRemoteDataSourceImpl>(
      () => BranchesRemoteDataSourceImpl(client: sl()));
  sl.registerFactory<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));
  sl.registerFactory<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerFactory<ComplaintsRemoteDataSource>(
      () => ComplaintsRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ClientRemoteDataSource>(
      () => ClientRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<BookingsRemoteDataSource>(
      () => BookingsRemoteDataSourceImpl(client: sl()));
//! Core

  // sl.registerFactory<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerFactory(() => sharedPreferences);
  sl.registerFactory(() => http.Client());
  // sl.registerFactory(() => InternetConnectionChecker());
}
