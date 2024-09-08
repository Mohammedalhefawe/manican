import 'package:equatable/equatable.dart';

class Complaint extends Equatable {
  final int? id;
  final int? branchId;
  final int? userId;
  final String? content;
  final DateTime? date;
  final String? day;
  final String? customerFirstName;
  final String? customerLastName;

  const Complaint(
      {required this.id,
      required this.branchId,
      required this.userId,
      required this.content,
      required this.date,
      required this.day,
      required this.customerFirstName,
      required this.customerLastName});

  @override
  List<Object?> get props => [
        id,
        branchId,
        userId,
        content,
        date,
        day,
        customerFirstName,
        customerLastName,
      ];
}
