import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manicann/features/clients/domain/repositories/clients_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/client.dart';

class EditClientUseCase {
  final ClientRepository repository;

  EditClientUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({
    required Client client,
    required PlatformFile? image,
  }) async {
    return await repository.editClient(client: client, image: image);
  }
}
