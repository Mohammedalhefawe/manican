import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/clients_repository.dart';

class DeclineBookingUseCase {
  final ClientRepository repository;

  DeclineBookingUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required int bookingId}) async {
    return await repository.declineBooking(bookingId: bookingId);
  }
}
