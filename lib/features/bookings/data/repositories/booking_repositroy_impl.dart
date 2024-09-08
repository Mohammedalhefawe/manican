import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:manicann/core/error/exceptions.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/features/bookings/domain/repositories/booking_repository.dart';
import 'package:manicann/features/clients/domain/entities/booking.dart';
import 'package:manicann/features/employees/data/models/file_employee_model.dart';
import 'package:manicann/features/employees/domain/entities/file_attendance.dart';
import '../datasources/booking_remote_data_source.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class BookingsRepositoryImpl implements BookingsRepository {
  final BookingsRemoteDataSource remoteDataSource;

  BookingsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Booking>>> getAllArchivedBookings(
      {required int branchId}) async {
    try {
      final List<Booking> archivedBookings =
          await remoteDataSource.getAllArchivedBookings(branchId: branchId);
      return Right(archivedBookings);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getAllCurrentBookings(
      {required int branchId}) async {
    try {
      final List<Booking> currentBookings =
          await remoteDataSource.getAllCurrentBookings(branchId: branchId);
      return Right(currentBookings);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> acceptBooking({required int bookingId}) async {
    return await _getMessage(() {
      return remoteDataSource.acceptBooking(bookingId: bookingId);
    });
  }

  @override
  Future<Either<Failure, Unit>> declineBooking({required int bookingId}) async {
    return await _getMessage(() {
      return remoteDataSource.declineBooking(bookingId: bookingId);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    try {
      await deleteOrUpdateOrAddPost();
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FileResponseModel>> downloadFileAttendance(
      DownloadFileEntity downloadFileEntity) async {
    if (true) {
      try {
        final FileResponseModel fileResponseModel =
            await remoteDataSource.downloadFileAttendance(downloadFileEntity);
        return Right(fileResponseModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
