import 'package:dartz/dartz.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/features/complaints/domain/entities/complaint.dart';

abstract class ComplaintRepository {
  Future<Either<Failure, List<Complaint>>> getAllComplaints(
      {required int branchId});
  Future<Either<Failure, Unit>> hideComplaint({required int complaintId});
}
