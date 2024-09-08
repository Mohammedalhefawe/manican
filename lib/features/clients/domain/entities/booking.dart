import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final int? id;
  final String? day;
  final String? date;
  final String? time;
  final String? endTime;
  final String? status;
  final String? customerFirstName;
  final String? customerMiddleName;
  final String? customerLastName;
  final String? serviceName;
  final int? employeeId;
  final String? employeeFirstName;
  final String? employeeLastName;

  const Booking({
    this.id,
    this.customerFirstName,
    this.customerMiddleName,
    this.customerLastName,
    this.day,
    this.date,
    this.time,
    this.endTime,
    this.serviceName,
    this.status,
    this.employeeId,
    this.employeeFirstName,
    this.employeeLastName,
  });

  @override
  List<Object?> get props => [
    customerFirstName,
    customerMiddleName,
    customerLastName,
    day,
    date,
    time,
    endTime,
    serviceName,
    status,
    employeeId,
    employeeFirstName,
    employeeLastName,
  ];
}

