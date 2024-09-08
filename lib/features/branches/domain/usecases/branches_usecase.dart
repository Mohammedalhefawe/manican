import 'package:dartz/dartz.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/features/Branches/data/repositories/Branches_repository_impl.dart';
import 'package:manicann/features/branches/data/models/branch_model.dart';
import 'package:manicann/features/branches/domain/entities/branch_entity.dart';

class BranchesUsecase {
  final BranchesRepositoryImpl repository;

  BranchesUsecase({required this.repository});

  Future<Either<Failure, Unit>> addBranch(BranchEntity branchEntity) async {
    return await repository.addBranch(branchEntity);
  }

  Future<Either<Failure, List<BranchModel>>> getAllBranches() async {
    return await repository.getAllBranches();
  }
}
