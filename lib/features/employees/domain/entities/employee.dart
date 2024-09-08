import 'package:equatable/equatable.dart';
import 'package:manicann/features/employees/domain/entities/service.dart';
import 'package:manicann/models.dart';

// ignore: must_be_immutable
class Employee extends Equatable {
  final int? id;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? phoneNumber;
  final int? branchId;
  final String? role;
  final double? salary;
  final double? ratio;
  final bool? isFixed;
  final String? position;
  final DateTime? startDate;
  final String? nationalId;
  final int? pin;
  final String? email;
  final String? password;
  final ImageModel? image;
  List<ServiceEntity>? services = [];

  Employee({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.phoneNumber,
    this.branchId,
    this.role,
    this.salary,
    this.ratio,
    this.isFixed,
    this.position,
    this.startDate,
    this.nationalId,
    this.pin,
    this.email,
    this.password,
    this.services,
    this.image,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        middleName,
        lastName,
        phoneNumber,
        role,
        salary,
        ratio,
        isFixed,
        position,
        startDate,
        nationalId,
        pin,
        email,
        password,
        services,
        image,
      ];
}
