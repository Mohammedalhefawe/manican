import 'package:dartz/dartz.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/features/booking/data/models/Services_employee_Model.dart';
import 'package:manicann/features/booking/data/models/available_time_model.dart';
import 'package:manicann/features/booking/data/models/users_model.dart';
import 'package:manicann/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:manicann/features/booking/domain/entities/booking_entity_data.dart';

class BookingUsecase {
  final BookingRepositoryImpl repository;

  BookingUsecase({required this.repository});

  Future<Either<Failure, ServiceEmployeeModel>>
      getAllServiceAndEmployee() async {
    return await repository.getAllServicesAndEmployee();
  }

  Future<Either<Failure, Unit>> addBooking(BookingEntity bookingEntity) async {
    return await repository.addBooking(bookingEntity);
  }

  Future<Either<Failure, List<AvailableTimeModel>>> getAvailableTime(
      String idService, String date) async {
    return await repository.getAvailableTime(idService, date);
  }

  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    return await repository.getAllUsers();
  }
}
