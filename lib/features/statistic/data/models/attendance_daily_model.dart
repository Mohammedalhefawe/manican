class AttendanceDailyModel {
  final int id;
  final String firstName;
  final String lastName;
  final String middleName;
  final int branchId;
  final String phoneNumber;
  final String? email; // Nullable
  final String role;
  final String? emailVerifiedAt; // Nullable
  final String createdAt;
  final String updatedAt;
  final ProfileImage? profileImage; // Nullable
  final List<Attendance> allAttendance;

  AttendanceDailyModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.branchId,
    required this.phoneNumber,
    this.email,
    required this.role,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.profileImage,
    required this.allAttendance,
  });

  factory AttendanceDailyModel.fromJson(Map<String, dynamic> json) {
    return AttendanceDailyModel(
      id: json['id'] ?? 0, // Default to 0 if null
      firstName: json['first_name'] ?? '', // Default to empty string
      lastName: json['last_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      branchId: json['branch_id'] ?? 0,
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'], // Nullable
      role: json['role'] ?? '',
      emailVerifiedAt: json['email_verified_at'], // Nullable
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      profileImage: json['profile_image'] != null
          ? ProfileImage.fromJson(json['profile_image'])
          : null, // Handle null case for profile_image
      allAttendance: json['all_attendance'] != null
          ? List<Attendance>.from(
              json['all_attendance'].map((x) => Attendance.fromJson(x)))
          : [], // Default to empty list if null
    );
  }
}

class ProfileImage {
  final int id;
  final String imageableType;
  final int imageableId;
  final String image;
  final String type;

  ProfileImage({
    required this.id,
    required this.imageableType,
    required this.imageableId,
    required this.image,
    required this.type,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      id: json['id'] ?? 0, // Default to 0 if null
      imageableType: json['imageable_type'] ?? '', // Default to empty string
      imageableId: json['imageable_id'] ?? 0, // Default to 0 if null
      image: json['image'] ?? '', // Default to empty string
      type: json['type'] ?? '', // Default to empty string
    );
  }
}

class Attendance {
  final int id;
  final String? checkIn; // Nullable
  final String? checkOut; // Nullable
  final String date;
  final int userId;
  final int branchId;
  final String day;
  final String status;

  Attendance({
    required this.id,
    this.checkIn,
    this.checkOut,
    required this.date,
    required this.userId,
    required this.branchId,
    required this.day,
    required this.status,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'] ?? 0,
      checkIn: json['checkIn'] ?? "04:01:11", // Nullable
      checkOut: json['checkOut'] ?? "05:01:11", // Nullable
      date: json['date'] ?? '',
      userId: json['user_id'] ?? 0,
      branchId: json['branch_id'] ?? 0,
      day: json['day'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
