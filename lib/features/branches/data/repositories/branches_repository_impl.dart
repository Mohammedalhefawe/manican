import 'package:dartz/dartz.dart';
import 'package:manicann/features/branches/data/datasources/branch_remote_data_source.dart';
import 'package:manicann/features/branches/data/models/branch_model.dart';
import 'package:manicann/features/branches/domain/entities/branch_entity.dart';
import 'package:manicann/features/branches/domain/repositories/Branches_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class BranchesRepositoryImpl implements BranchesRepository {
  final BranchesRemoteDataSource remoteDataSource;
  BranchesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<BranchModel>>> getAllBranches() async {
    if (true) {
      try {
        final remoteBranches = await remoteDataSource.getAllBranches();
        return Right(remoteBranches);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addBranch(BranchEntity branchEntity) async {
    if (true) {
      try {
        await remoteDataSource.addBranch(branchEntity);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
