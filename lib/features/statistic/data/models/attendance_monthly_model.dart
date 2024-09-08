class AttendanceYearlyModel {
  MonthAttendance january;
  MonthAttendance february;
  MonthAttendance march;
  MonthAttendance april;
  MonthAttendance may;
  MonthAttendance june;
  MonthAttendance july;
  MonthAttendance august;
  MonthAttendance september;
  MonthAttendance october;
  MonthAttendance november;
  MonthAttendance december;

  AttendanceYearlyModel({
    required this.january,
    required this.february,
    required this.march,
    required this.april,
    required this.may,
    required this.june,
    required this.july,
    required this.august,
    required this.september,
    required this.october,
    required this.november,
    required this.december,
  });

  factory AttendanceYearlyModel.fromJson(Map<String, dynamic> json) {
    return AttendanceYearlyModel(
      january: MonthAttendance.fromJson(json['January']),
      february: MonthAttendance.fromJson(json['February']),
      march: MonthAttendance.fromJson(json['March']),
      april: MonthAttendance.fromJson(json['April']),
      may: MonthAttendance.fromJson(json['May']),
      june: MonthAttendance.fromJson(json['June']),
      july: MonthAttendance.fromJson(json['July']),
      august: MonthAttendance.fromJson(json['August']),
      september: MonthAttendance.fromJson(json['September']),
      october: MonthAttendance.fromJson(json['October']),
      november: MonthAttendance.fromJson(json['November']),
      december: MonthAttendance.fromJson(json['December']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'January': january.toJson(),
      'February': february.toJson(),
      'March': march.toJson(),
      'April': april.toJson(),
      'May': may.toJson(),
      'June': june.toJson(),
      'July': july.toJson(),
      'August': august.toJson(),
      'September': september.toJson(),
      'October': october.toJson(),
      'November': november.toJson(),
      'December': december.toJson(),
    };
  }
}

class MonthAttendance {
  double attendances;

  double absences;
  double lates;

  MonthAttendance({
    required this.attendances,
    required this.absences,
    required this.lates,
  });

  factory MonthAttendance.fromJson(Map<String, dynamic> json) {
    return MonthAttendance(
      attendances: json['attendances'],
      absences: json['absences'],
      lates: json['lates'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attendances': attendances,
      'absences': absences,
      'lates': lates,
    };
  }
}
