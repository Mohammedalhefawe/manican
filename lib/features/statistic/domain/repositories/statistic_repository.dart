import 'package:dartz/dartz.dart';
import 'package:manicann/features/statistic/data/models/attendance_daily_model.dart';
import 'package:manicann/features/statistic/data/models/attendance_monthly_model.dart';
import 'package:manicann/features/statistic/data/models/attendance_weekly_model.dart';
import 'package:manicann/features/statistic/data/models/statistic_model.dart';

import '../../../../core/error/failures.dart';

abstract class StatisticsRepository {
  Future<Either<Failure, StatisticModel>> getAllStatistics();
  Future<Either<Failure, AttendanceYearlyModel>> getAllAttendanceForYear(
      String date);
  Future<Either<Failure, AttendanceMonthlyModel>> getAllAttendanceForMonth(
      String date);
  // Future<Either<Failure, List<ServiceEntity>>> getAllAttendanceByType();
  Future<Either<Failure, List<AttendanceDailyModel>>> getAllDailyAttendance();
}
