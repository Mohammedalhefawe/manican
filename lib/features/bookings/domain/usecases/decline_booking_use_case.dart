import 'package:dartz/dartz.dart';
import 'package:manicann/features/bookings/domain/repositories/booking_repository.dart';
import '../../../../core/error/failures.dart';

class DeclineBranchBookingUseCase {
  final BookingsRepository repository;

  DeclineBranchBookingUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required int bookingId}) async {
    return await repository.declineBooking(bookingId: bookingId);
  }
}
