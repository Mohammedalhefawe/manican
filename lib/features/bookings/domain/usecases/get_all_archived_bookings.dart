import 'package:dartz/dartz.dart';
import 'package:manicann/features/bookings/domain/repositories/booking_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../clients/domain/entities/booking.dart';

class GetAllArchivedBookingsUseCase {
  final BookingsRepository repository;

  GetAllArchivedBookingsUseCase({required this.repository});

  Future<Either<Failure, List<Booking>>> call({required int branchId}) async {
    return await repository.getAllArchivedBookings(branchId: branchId);
  }
}
