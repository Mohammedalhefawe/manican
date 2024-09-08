import 'package:manicann/models.dart';

import '../../domain/entities/client.dart';

class ClientModel extends Client {
  const ClientModel({
    super.id,
    super.firstName,
    super.middleName,
    super.lastName,
    super.phoneNumber,
    super.branchId,
    super.email,
    super.image,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      branchId: json['branch_id'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      image: json['profile_image'] != null
          ? ImageModel.fromJson(json['profile_image'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (firstName != null) "first_name": firstName,
      if (middleName != null) "middle_name": middleName,
      if (lastName != null) "last_name": lastName,
      if (branchId != null) "branch_id": "$branchId",
      if (phoneNumber != null) "phone_number": phoneNumber,
      if (email != null) "email": email,
      if (image != null) "profile_image": image,
    };
  }
}
