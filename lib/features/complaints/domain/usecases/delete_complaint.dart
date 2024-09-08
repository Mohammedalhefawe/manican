import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/complaints_repository.dart';

class HideComplaintUseCase {
  final ComplaintRepository repository;

  HideComplaintUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required int complaintId}) async {
    return await repository.hideComplaint(complaintId: complaintId);
  }
}
