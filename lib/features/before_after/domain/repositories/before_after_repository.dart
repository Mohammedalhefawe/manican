import 'package:dartz/dartz.dart';
import 'package:manicann/features/before_after/data/models/before_after_model.dart';

import 'package:manicann/features/before_after/domain/entities/before_after_entity_data.dart';

import '../../../../core/error/failures.dart';

abstract class BeforeAfterRepository {
  Future<Either<Failure, List<BeforeAfterModel>>> getAllBeforeAfter();
  Future<Either<Failure, Unit>> addBeforeAfter(
      BeforeAfterEntityData beforeAfterEntityData);
  Future<Either<Failure, Unit>> editBeforeAfter(
      BeforeAfterEntityData beforeAfterEntityData);
  Future<Either<Failure, Unit>> deleteBeforeAfter(String idBeforAfter);
}
