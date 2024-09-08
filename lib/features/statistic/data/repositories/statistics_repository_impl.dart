import 'package:dartz/dartz.dart';
import 'package:manicann/features/statistic/data/datasources/statistics_remote_data_source.dart';
import 'package:manicann/features/statistic/data/models/attendance_daily_model.dart';
import 'package:manicann/features/statistic/data/models/attendance_monthly_model.dart';
import 'package:manicann/features/statistic/data/models/attendance_weekly_model.dart';
import 'package:manicann/features/statistic/data/models/statistic_model.dart';
import 'package:manicann/features/statistic/domain/repositories/statistic_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticRemoteDataSource remoteDataSource;

  StatisticsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, StatisticModel>> getAllStatistics() async {
    if (true) {
      try {
        final remoteStatistics = await remoteDataSource.getAllStatistics();
        return Right(remoteStatistics);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, AttendanceMonthlyModel>> getAllAttendanceForMonth(
      String date) async {
    if (true) {
      try {
        final remoteStatistics =
            await remoteDataSource.getAllAttendanceForMonth(date);
        return Right(remoteStatistics);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, AttendanceYearlyModel>> getAllAttendanceForYear(
      String date) async {
    if (true) {
      try {
        final remoteStatistics =
            await remoteDataSource.getAllAttendanceForYear(date);
        return Right(remoteStatistics);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<AttendanceDailyModel>>>
      getAllDailyAttendance() async {
    if (true) {
      try {
        final remoteStatistics = await remoteDataSource.getAllDailyAttendance();
        return Right(remoteStatistics);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
