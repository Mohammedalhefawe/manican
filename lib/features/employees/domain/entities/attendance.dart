import 'package:equatable/equatable.dart';

class Attendance extends Equatable{
  final int? id;
  final int? userId;
  final int? branchId;
  final bool? isAbsence;
  final DateTime? date;
  final String? day;

  const Attendance({
    required this.id,
    required this.userId,
    required this.branchId,
    required this.isAbsence,
    required this.date,
    required this.day,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    branchId,
    isAbsence,
    date,
    day
  ];
}
