import 'dart:convert';
import 'package:manicann/features/employees/data/models/service_model.dart';
import 'package:manicann/features/employees/domain/entities/employee.dart';
import 'package:manicann/models.dart';

// ignore: must_be_immutable
class EmployeeModel extends Employee {
  EmployeeModel({
    super.id,
    super.firstName,
    super.middleName,
    super.lastName,
    super.phoneNumber,
    super.branchId,
    super.role,
    super.salary,
    super.ratio,
    super.isFixed,
    super.position,
    super.startDate,
    super.nationalId,
    super.pin,
    super.email,
    super.password,
    super.services,
    super.image,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> serviceList = json['services'] ?? [];
    final List<ServiceModel> parsedServices = serviceList.map((service) {
      return ServiceModel.fromJson(service);
    }).toList();

    print(json);

    return EmployeeModel(
      id: json['id'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      branchId: json['branch_id'] ?? 1,
      phoneNumber: json['phone_number'],
      role: json['role'],
      email: json['email'],
      password: json['password'],
      ratio: json['employee']['ratio'],
      pin: json['employee']['pin'],
      nationalId: json['employee']['national_id'],
      position: json['employee']['position'],
      startDate: json['employee']['start_date'] != null
          ? DateTime.parse(json['employee']['start_date'])
          : null,
      isFixed: json['employee']['isFixed'] == 0 ? false : true,
      image: json['profile_image'] != null
          ? ImageModel.fromJson(json['profile_image'])
          : null,
      services: parsedServices,
    );
  }

  Map<String, dynamic> toJson() {
    var emp = {
      if (firstName != null) "first_name": firstName,
      if (middleName != null) "middle_name": middleName,
      if (lastName != null) "last_name": lastName,
      if (branchId != null) "branch_id": "$branchId",
      if (phoneNumber != null) "phone_number": phoneNumber,
      if (role != null) "role": role,
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (salary != null) "salary": "$salary",
      if (ratio != null) "ratio": "$ratio",
      if (pin != null) "pin": "$pin",
      if (nationalId != null) "national_id": nationalId,
      if (position != null) "position": position,
      if (startDate != null)
        "start_date":
            "${startDate?.year}-${(startDate!.month / 10).floor()}${(startDate?.month)! % 10}-${startDate?.day}",
      if (isFixed != null) "isFixed": isFixed == true ? "1" : "0",
      if (image != null) "profile_image": image,
      "description": "employee"
    };
    var encodedEmp = json.encode(emp);
    var decodedJson = json.decode(encodedEmp) as Map<String, dynamic>;
    if (services != null) {
      for (int i = 0; i < services!.length; i++) {
        decodedJson.addAll({"services[$i]": "${services![i].id}"});
      }
    }
    return decodedJson;
  }
}
      // salary: json['employee']['salary'],
