import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/error/failures.dart';
import '../entities/client.dart';
import '../repositories/clients_repository.dart';

class AddClientUseCase {
  final ClientRepository repository;

  AddClientUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({
    required Client client,
    required PlatformFile? image
  }) async {
    return await repository.addClient(client: client , image: image);
  }
}