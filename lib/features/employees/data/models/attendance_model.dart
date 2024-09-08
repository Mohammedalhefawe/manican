import 'package:manicann/features/employees/domain/entities/attendance.dart';

class AttendanceModel extends Attendance {
  const AttendanceModel({
    super.id,
    super.userId,
    super.branchId,
    super.isAbsence,
    super.date,
    super.day,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json){
    return AttendanceModel(
      id: json['id'],
      userId: json['user_id'],
      branchId: json['branch_id'],
      isAbsence: json['isAbsence'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      day: json['day'],
    );
    /*catch(e){
      print(e.toString());
      return AttendanceModel.fromJson(json);
  }*/
  }

}
