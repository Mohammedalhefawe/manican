import 'package:dartz/dartz.dart';
import 'package:manicann/features/before_after/data/models/before_after_model.dart';
import 'package:manicann/features/before_after/data/repositories/before_after_repository_impl.dart';
import 'package:manicann/features/before_after/domain/entities/before_after_entity_data.dart';
import '../../../../core/error/failures.dart';

class BeforeAfterUsecase {
  final BeforeAfterRepositoryImpl repository;

  BeforeAfterUsecase({required this.repository});

  Future<Either<Failure, List<BeforeAfterModel>>> getAllBeforeAfter() async {
    return await repository.getAllBeforeAfter();
  }

  Future<Either<Failure, Unit>> editBeforeAfter(
      BeforeAfterEntityData beforeAfterEntityData) async {
    return await repository.editBeforeAfter(beforeAfterEntityData);
  }

  Future<Either<Failure, Unit>> deleteBeforeAfter(String idBeforAfter) async {
    return await repository.deleteBeforeAfter(idBeforAfter);
  }

  Future<Either<Failure, Unit>> addBeforeAfter(
      BeforeAfterEntityData beforeAfterEntityData) async {
    return await repository.addBeforeAfter(beforeAfterEntityData);
  }
}
