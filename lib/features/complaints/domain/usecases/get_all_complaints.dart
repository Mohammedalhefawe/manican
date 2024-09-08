import 'package:dartz/dartz.dart';
import 'package:manicann/features/complaints/domain/entities/complaint.dart';
import 'package:manicann/features/complaints/domain/repositories/complaints_repository.dart';
import '../../../../core/error/failures.dart';

class GetAllComplaintsUseCase {
  final ComplaintRepository repository;

  GetAllComplaintsUseCase({required this.repository});

  Future<Either<Failure, List<Complaint>>> call({required int branchId}) async {
    return await repository.getAllComplaints(branchId: branchId);
  }
}
