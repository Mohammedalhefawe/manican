import 'package:dartz/dartz.dart';
import 'package:manicann/features/clients/domain/entities/client_booking_percentage.dart';
import '../../../../core/error/failures.dart';
import '../repositories/clients_repository.dart';

class GetBookingPercentageUseCase {
  final ClientRepository repository;

  GetBookingPercentageUseCase({required this.repository});

  Future<Either<Failure, BookingPercentage>> call(
      {required int clientId}) async {
    return await repository.getClientBookingPercentage(clientId: clientId);
  }
}
