import 'dart:convert';

import 'package:manicann/models.dart';

class BranchModel {
  final int id;
  final String name;
  final String location;
  final String startTime;
  final String endTime;
  final String description;
  final String clientCount;
  final String employeeCount;
  final List<String> workingDays;
  ImageModel? image;
  BranchModel({
    required this.clientCount,
    required this.employeeCount,
    required this.id,
    required this.name,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.workingDays,
    this.image,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      description: json['description'],
      clientCount: json['client_count'].toString(),
      employeeCount: json['employee_count'].toString(),
      workingDays: List<String>.from(jsonDecode(json['working_days'])),
      image: json['image'] != null ? ImageModel.fromJson(json['image']) : null,
    );
  }
}
