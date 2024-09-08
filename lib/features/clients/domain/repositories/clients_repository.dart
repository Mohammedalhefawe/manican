import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manicann/core/error/failures.dart';

import '../entities/booking.dart';
import '../entities/client.dart';
import '../entities/client_booking_percentage.dart';

abstract class ClientRepository {
  Future<Either<Failure, List<Client>>> getAllClients({required int branchId});
  Future<Either<Failure, Client>> getClientDetails(int id);
  Future<Either<Failure, Unit>> addClient(
      {required Client client, required PlatformFile? image});
  Future<Either<Failure, Unit>> editClient({
    required Client client,
    required PlatformFile? image,
  });
  Future<Either<Failure, Unit>> deleteClient({required int clientId});
  Future<Either<Failure, List<Booking>>> getCurrentClientBookings(
      {required int clientId});
  Future<Either<Failure, List<Booking>>> getArchivedClientBookings(
      {required int clientId});
  Future<Either<Failure, Unit>> acceptBooking({required int bookingId});
  Future<Either<Failure, Unit>> declineBooking({required int bookingId});
  Future<Either<Failure, BookingPercentage>> getClientBookingPercentage(
      {required int clientId});
}
