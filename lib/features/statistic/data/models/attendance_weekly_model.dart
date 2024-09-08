class AttendanceMonthlyModel {
  final AttendanceWeeklyData week1;
  final AttendanceWeeklyData week2;
  final AttendanceWeeklyData week3;
  final AttendanceWeeklyData week4;

  AttendanceMonthlyModel({
    required this.week1,
    required this.week2,
    required this.week3,
    required this.week4,
  });

  factory AttendanceMonthlyModel.fromJson(Map<String, dynamic> json) {
    return AttendanceMonthlyModel(
      week1: AttendanceWeeklyData.fromJson(json['week_1']),
      week2: AttendanceWeeklyData.fromJson(json['week_2']),
      week3: AttendanceWeeklyData.fromJson(json['week_3']),
      week4: AttendanceWeeklyData.fromJson(json['week_4']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week_1': week1.toJson(),
      'week_2': week2.toJson(),
      'week_3': week3.toJson(),
      'week_4': week4.toJson(),
    };
  }
}

class AttendanceWeeklyData {
  final int absencesCount;
  final int attendanceCount;
  final int latesCount;

  AttendanceWeeklyData({
    required this.absencesCount,
    required this.attendanceCount,
    required this.latesCount,
  });

  factory AttendanceWeeklyData.fromJson(Map<String, dynamic> json) {
    return AttendanceWeeklyData(
      absencesCount: json['absences_count'] as int,
      attendanceCount: json['attendance_count'] as int,
      latesCount: json['lates_count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'absences_count': absencesCount,
      'attendance_count': attendanceCount,
      'lates_count': latesCount,
    };
  }
}
