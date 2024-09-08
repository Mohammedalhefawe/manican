import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  final String imageUrl;
  final String name;
  final String designation;
  final String checkInTime;
  final bool status;

  const Attendance(
      {required this.imageUrl,
      required this.name,
      required this.designation,
      required this.checkInTime,
      required this.status});

  @override
  List<Object?> get props => [imageUrl, name, designation, checkInTime, status];
}
