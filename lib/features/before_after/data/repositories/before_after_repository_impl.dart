import 'package:dartz/dartz.dart';
import 'package:manicann/features/before_after/data/datasources/before_after_remote_data_source.dart';
import 'package:manicann/features/before_after/data/models/before_after_model.dart';
import 'package:manicann/features/before_after/domain/entities/before_after_entity_data.dart';
import 'package:manicann/features/before_after/domain/repositories/before_after_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class BeforeAfterRepositoryImpl implements BeforeAfterRepository {
  final BeforeAfterRemoteDataSource remoteDataSource;

  BeforeAfterRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<BeforeAfterModel>>> getAllBeforeAfter() async {
    if (true) {
      try {
        final remoteBeforeAfter = await remoteDataSource.getAllBeforeAfter();
        return Right(remoteBeforeAfter);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addBeforeAfter(
      BeforeAfterEntityData beforeAfterEntityData) async {
    if (true) {
      try {
        await remoteDataSource.addBeforeAfter(beforeAfterEntityData);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> editBeforeAfter(
      BeforeAfterEntityData beforeAfterEntityData) async {
    if (true) {
      try {
        await remoteDataSource.editBeforeAfter(beforeAfterEntityData);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBeforeAfter(String idBeforAfter) async {
    if (true) {
      try {
        await remoteDataSource.deleteBeforeAfter(idBeforAfter);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
