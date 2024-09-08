import 'dart:convert';

class ServiceEmployeeModel {
  final int id;
  final String name;
  final String location;
  final String startTime;
  final String endTime;
  final String description;
  final List<String> workingDays;
  final List<Service> services;

  ServiceEmployeeModel({
    required this.id,
    required this.name,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.workingDays,
    required this.services,
  });

  factory ServiceEmployeeModel.fromJson(Map<String, dynamic> json) {
    return ServiceEmployeeModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown', // Default value for name
      location:
          json['location'] ?? 'Unknown Location', // Default value for location
      startTime: json['start_time'] ?? '00:00', // Default value for startTime
      endTime: json['end_time'] ?? '00:00', // Default value for endTime
      description: json['description'] ??
          'No description provided', // Default value for description
      workingDays: [], // Default working days
      services: json['services'] != null
          ? List<Service>.from(json['services'].map((x) => Service.fromJson(x)))
          : [], // Default to empty list if services are null
    );
  }
}

class Service {
  final int id;
  final int branchId;
  final String name;
  final int period;
  final double price;
  final String from;
  final String to;
  final double newPrice;
  final List<Employee> employees;

  Service({
    required this.id,
    required this.branchId,
    required this.name,
    required this.period,
    double? price, // Optional parameter
    required this.from,
    required this.to,
    double? newPrice, // Optional parameter
    required this.employees,
  })  : price = price ?? 0.0, // Default value for price
        newPrice = newPrice ?? 0.0; // Default value for newPrice

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      branchId: json['branch_id'],
      name: json['name'] ?? 'Unnamed Service', // Default value for name
      period: json['period'] ?? 0, // Default value for period
      price: json['price'] != null
          ? json['price'].toDouble()
          : 0.0, // Default value for price
      from: json['from'] ?? '00:00', // Default value for from
      to: json['to'] ?? '00:00', // Default value for to
      newPrice: json['newPrice'] != null
          ? json['newPrice'].toDouble()
          : 0.0, // Default value for newPrice
      employees: json['employees'] != null
          ? List<Employee>.from(
              json['employees'].map((x) => Employee.fromJson(x)))
          : [], // Default to empty list if employees are null
    );
  }
}

class Employee {
  final int id;
  final String firstName;
  final String lastName;
  final String middleName;
  final int branchId;
  final String phoneNumber;
  final String email; // Changed to non-nullable
  final String role;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.branchId,
    required this.phoneNumber,
    String? email, // Optional parameter
    required this.role,
  }) : email = email ?? 'noemail@example.com'; // Default value for email

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      firstName:
          json['first_name'] ?? 'First Name', // Default value for firstName
      lastName: json['last_name'] ?? 'Last Name', // Default value for lastName
      middleName: json['middle_name'] ?? '', // Default value for middleName
      branchId: json['branch_id'] ?? 0, // Default value for branchId
      phoneNumber: json['phone_number'] ??
          '000-000-0000', // Default value for phoneNumber
      email: json['email'] ?? 'noemail@example.com', // Default value for email
      role: json['role'] ?? 'Employee', // Default value for role
    );
  }
}
