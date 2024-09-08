import 'package:dartz/dartz.dart';
import 'package:manicann/features/clients/domain/entities/client.dart';
import 'package:manicann/features/clients/domain/repositories/clients_repository.dart';
import '../../../../core/error/failures.dart';

class GetAllClientsUseCase {
  final ClientRepository repository;

  GetAllClientsUseCase({required this.repository});

  Future<Either<Failure, List<Client>>> call({required int branchId}) async {
    return await repository.getAllClients(branchId: branchId);
  }
}
