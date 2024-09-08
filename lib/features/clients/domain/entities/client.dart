import 'package:equatable/equatable.dart';
import 'package:manicann/models.dart';

class Client extends Equatable {
  final int? id;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? phoneNumber;
  final int? branchId;
  final String? email;
  final ImageModel? image;

  const Client({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.phoneNumber,
    this.branchId,
    this.email,
    this.image,
  });

  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      middleName,
      lastName,
      phoneNumber,
      email,
      branchId,
    ];
  }
}
