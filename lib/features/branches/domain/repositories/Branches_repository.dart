import 'package:dartz/dartz.dart';
import 'package:manicann/features/branches/data/models/branch_model.dart';
import 'package:manicann/features/branches/domain/entities/branch_entity.dart';
import '../../../../core/error/failures.dart';

abstract class BranchesRepository {
  Future<Either<Failure, List<BranchModel>>> getAllBranches();
  Future<Either<Failure, Unit>> addBranch(BranchEntity branchEntity);
}
