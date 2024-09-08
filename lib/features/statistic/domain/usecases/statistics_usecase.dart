import 'package:dartz/dartz.dart';
import 'package:manicann/features/statistic/data/models/attendance_daily_model.dart';
import 'package:manicann/features/statistic/data/models/attendance_monthly_model.dart';
import 'package:manicann/features/statistic/data/models/attendance_weekly_model.dart';
import 'package:manicann/features/statistic/data/models/statistic_model.dart';
import 'package:manicann/features/statistic/data/repositories/statistics_repository_impl.dart';
import '../../../../core/error/failures.dart';

class StatisticsUsecase {
  final StatisticsRepositoryImpl repository;
  StatisticsUsecase({required this.repository});
  Future<Either<Failure, StatisticModel>> getAllStatistics() {
    return repository.getAllStatistics();
  }

  Future<Either<Failure, AttendanceYearlyModel>> getAllAttendanceForYear(
      String date) {
    return repository.getAllAttendanceForYear(date);
  }

  Future<Either<Failure, AttendanceMonthlyModel>> getAllAttendanceForMonth(
      String date) {
    return repository.getAllAttendanceForMonth(date);
  }

  // Future<Either<Failure, List<ServiceEntity>>> getAllAttendanceByType();
  Future<Either<Failure, List<AttendanceDailyModel>>> getAllDailyAttendance() {
    return repository.getAllDailyAttendance();
  }
}
