import 'package:manicann/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.phoneNumber,
    required super.branchId,
    required super.role,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["user"]["id"],
      firstName: json["user"]["first_name"],
      middleName: json["user"]["middle_name"],
      lastName: json["user"]["last_name"],
      phoneNumber: json["user"]["phone_number"],
      branchId: json["user"]["branch_id"],
      role: json["user"]["role"],
      token: json["authorisation"]["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "branch_id": branchId,
        "role": role
      },
      "authorisation": {"token": token}
    };
  }
}
