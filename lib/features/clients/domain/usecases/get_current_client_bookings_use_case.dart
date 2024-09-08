import 'package:dartz/dartz.dart';
import 'package:manicann/features/clients/domain/repositories/clients_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/booking.dart';

class GetCurrentClientBookingsUseCase {
  final ClientRepository repository;

  GetCurrentClientBookingsUseCase({required this.repository});

  Future<Either<Failure, List<Booking>>> call({required int clientId}) async {
    return await repository.getCurrentClientBookings(clientId: clientId);
  }
}
