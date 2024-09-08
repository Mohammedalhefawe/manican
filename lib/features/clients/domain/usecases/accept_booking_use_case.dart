import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/clients_repository.dart';

class AcceptBookingUseCase {
  final ClientRepository repository;

  AcceptBookingUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required int bookingId}) async {
    return await repository.acceptBooking(bookingId: bookingId);
  }
}
