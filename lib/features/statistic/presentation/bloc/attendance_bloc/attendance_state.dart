abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class ChangeElementInDropDownState extends AttendanceState {}

class ViewAllState extends AttendanceState {}

class SuccessAttendanceState extends AttendanceState {}

class LoadingAttendanceState extends AttendanceState {}

class ErrorAttendanceState extends AttendanceState {}
