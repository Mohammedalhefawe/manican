import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:manicann/core/error/exceptions.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/features/complaints/data/datasources/complaints_remote_data_source.dart';
import 'package:manicann/features/complaints/domain/entities/complaint.dart';
import 'package:manicann/features/complaints/domain/repositories/complaints_repository.dart';

class ComplaintRepositoryImpl implements ComplaintRepository {
  final ComplaintsRemoteDataSource remoteDataSource;

  ComplaintRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Complaint>>> getAllComplaints(
      {required int branchId}) async {
    try {
      final List<Complaint> complaintsList =
          await remoteDataSource.getAllComplaints(branchId: branchId);
      return Right(complaintsList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> hideComplaint(
      {required int complaintId}) async {
    try {
      await remoteDataSource.hideComplaint(complaintId: complaintId);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
