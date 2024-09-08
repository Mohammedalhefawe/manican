import 'package:dartz/dartz.dart';
import 'package:manicann/features/booking/data/models/Services_employee_Model.dart';
import 'package:manicann/features/booking/data/models/available_time_model.dart';
import 'package:manicann/features/booking/data/models/users_model.dart';
import 'package:manicann/features/booking/domain/entities/booking_entity_data.dart';
import '../../../../core/error/failures.dart';

abstract class BookingRepository {
  Future<Either<Failure, ServiceEmployeeModel>> getAllServicesAndEmployee();
  Future<Either<Failure, Unit>> addBooking(BookingEntity bookingEntitiy);
  Future<Either<Failure, List<AvailableTimeModel>>> getAvailableTime(
      String idService, String date);

  Future<Either<Failure, List<UserModel>>> getAllUsers();
}
