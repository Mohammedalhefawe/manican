import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/clients_repository.dart';

class DeleteClientUseCase {
  final ClientRepository repository;

  DeleteClientUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required int clientId}) async {
    return await repository.deleteClient(clientId: clientId);
  }
}
