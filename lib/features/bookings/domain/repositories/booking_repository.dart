import 'package:dartz/dartz.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/features/clients/domain/entities/booking.dart';
import 'package:manicann/features/employees/data/models/file_employee_model.dart';
import 'package:manicann/features/employees/domain/entities/file_attendance.dart';

abstract class BookingsRepository {
  Future<Either<Failure, List<Booking>>> getAllCurrentBookings(
      {required int branchId});
  Future<Either<Failure, List<Booking>>> getAllArchivedBookings(
      {required int branchId});
  Future<Either<Failure, Unit>> acceptBooking({required int bookingId});
  Future<Either<Failure, Unit>> declineBooking({required int bookingId});
  Future<Either<Failure, FileResponseModel>> downloadFileAttendance(
      DownloadFileEntity downloadFileEntity);
}
