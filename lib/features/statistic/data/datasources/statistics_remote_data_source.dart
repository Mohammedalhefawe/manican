import 'dart:convert';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/statistic/data/models/attendance_daily_model.dart';
import 'package:manicann/features/statistic/data/models/attendance_monthly_model.dart';
import 'package:manicann/features/statistic/data/models/attendance_weekly_model.dart';
import 'package:manicann/features/statistic/data/models/statistic_model.dart';
import '../../../../core/error/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class StatisticRemoteDataSource {
  Future<StatisticModel> getAllStatistics();
  Future<AttendanceYearlyModel> getAllAttendanceForYear(String date);
  Future<AttendanceMonthlyModel> getAllAttendanceForMonth(String date);
  // Future<Either<Failure, List<attendanceEntity>>> getAllAttendanceByType();
  Future<List<AttendanceDailyModel>> getAllDailyAttendance();
}

class StatisticRemoteDataSourceImpl implements StatisticRemoteDataSource {
  final http.Client client;
  StatisticRemoteDataSourceImpl({required this.client});
  @override
  Future<StatisticModel> getAllStatistics() async {
    final response = await client.get(
      Uri.parse(
          "${AppLink.baseUrl}branch/get-statistic-for-branch/${AppLink.branchId}"),
    );
    print('getAllStatistics................');
    print(response.body);
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      final Map<String, dynamic> decodedJson = data['data'];

      final StatisticModel statisticModel =
          StatisticModel.fromJson(decodedJson);
      print(response.statusCode);

      return statisticModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AttendanceYearlyModel> getAllAttendanceForYear(String date) async {
    final response = await client.get(
      Uri.parse(
          "${AppLink.baseUrl}branch/get-digram-statistic-for-branch/${AppLink.branchId}?status=yearly&date=${date.toString()}"),
    );
    print('getAllAttendanceForYear................');
    print(response.body);
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      final Map<String, dynamic> decodedJson = data['data'];

      final AttendanceYearlyModel attendanceModels =
          AttendanceYearlyModel.fromJson(decodedJson);
      return attendanceModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AttendanceMonthlyModel> getAllAttendanceForMonth(String date) async {
    final response = await client.get(
      Uri.parse(
          "${AppLink.baseUrl}branch/get-digram-statistic-for-branch/${AppLink.branchId}?status=monthly&date=${date.toString()}"),
    );
    print('getAllAttendanceForMonth................');
    print(response.body);
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      final Map<String, dynamic> decodedJson = data['data'];
      final AttendanceMonthlyModel attendanceModels =
          AttendanceMonthlyModel.fromJson(decodedJson);
      return attendanceModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<AttendanceDailyModel>> getAllDailyAttendance() async {
    final response = await client.get(
      Uri.parse(
          "${AppLink.baseUrl}attendance/get-daily-attendance/${AppLink.branchId}"),
    );
    print('getAllDailyAttendance................');
    print(response.body);
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      final List decodedJson = data['data'] as List;
      final List<AttendanceDailyModel> attendanceModels = decodedJson
          .map<AttendanceDailyModel>((jsonattendanceModel) =>
              AttendanceDailyModel.fromJson(jsonattendanceModel))
          .toList();

      return attendanceModels;
    } else {
      throw ServerException();
    }
  }
}
