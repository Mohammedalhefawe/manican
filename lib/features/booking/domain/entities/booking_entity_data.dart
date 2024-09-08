class BookingEntity {
  String userId;
  // String branchId;
  String employeeId;
  String operationId;
  String date;
  String time;

  BookingEntity({
    required this.userId,
    // required this.branchId,
    required this.employeeId,
    required this.operationId,
    required this.date,
    required this.time,
  });
}
