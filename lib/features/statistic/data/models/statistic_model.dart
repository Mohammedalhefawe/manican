class StatisticModel {
  final String totalEmployees;
  final String totalCustomers;
  final String totalDoctors;
  final String totalServices;

  StatisticModel({
    required this.totalEmployees,
    required this.totalCustomers,
    required this.totalDoctors,
    required this.totalServices,
  });

  factory StatisticModel.fromJson(Map<String, dynamic> json) {
    return StatisticModel(
      totalEmployees: _convertToString(json['total_employees']),
      totalCustomers: _convertToString(json['total_customers']),
      totalDoctors: _convertToString(json['total_doctors']),
      totalServices: _convertToString(json['total_services']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_employees': totalEmployees,
      'total_customers': totalCustomers,
      'total_doctors': totalDoctors,
      'total_services': totalServices,
    };
  }

  // Helper method to convert values to string or return "0" if null
  static String _convertToString(dynamic value) {
    if (value == null) {
      return '0'; // Default value for null
    } else if (value is String) {
      return value; // Already a string
    } else {
      return value.toString(); // Convert to string
    }
  }
}
