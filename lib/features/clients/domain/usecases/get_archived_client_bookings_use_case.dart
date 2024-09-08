import 'package:dartz/dartz.dart';
import 'package:manicann/features/clients/domain/entities/booking.dart';
import 'package:manicann/features/clients/domain/repositories/clients_repository.dart';
import '../../../../core/error/failures.dart';

class GetArchivedClientBookingsUseCase {
  final ClientRepository repository;

  GetArchivedClientBookingsUseCase({required this.repository});

  Future<Either<Failure, List<Booking>>> call({required int clientId}) async {
    return await repository.getArchivedClientBookings(clientId: clientId);
  }
}
