import 'package:equatable/equatable.dart';

class User extends Equatable{
  final int id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String phoneNumber;
  final int? branchId;
  final String role;
  final String token;

  const User({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.branchId,
    required this.role,
    required this.token,
  });

  @override
  List<Object?> get props => [id, firstName, middleName, lastName, phoneNumber, branchId, role, token];


}