import 'package:manicann/features/complaints/domain/entities/complaint.dart';

class ComplaintModel extends Complaint {
  const ComplaintModel({
    required super.id,
    required super.branchId,
    required super.userId,
    required super.content,
    required super.date,
    required super.day,
    required super.customerFirstName,
    required super.customerLastName,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      userId: json["user_id"],
      branchId: json['branch_id'],
      content: json['content'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      day: json['day'],
      customerFirstName: json["user"]['first_name'],
      customerLastName: json["user"]['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "branch_id": branchId,
      "date": date.toString(),
      "day": day,
      "content": content,
      "user": {
        "first_name": customerFirstName,
        "last_name": customerLastName,
      },
    };
  }
}
