class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String middleName;

  UserModel({
    this.id = 0,
    this.firstName = '',
    this.lastName = '',
    this.middleName = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      middleName: json['middle_name'] ?? '',
    );
  }
}
