import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/booking_repository.dart';

class AcceptBranchBookingUseCase {
  final BookingsRepository repository;

  AcceptBranchBookingUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required int bookingId}) async {
    return await repository.acceptBooking(bookingId: bookingId);
  }
}
