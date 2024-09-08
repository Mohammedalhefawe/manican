import 'package:manicann/features/clients/domain/entities/client_booking_percentage.dart';

class BookingPercentageModel extends BookingPercentage {
  const BookingPercentageModel(
      {required super.customerPercentage, required super.othersPercentage});

  factory BookingPercentageModel.fromJson(Map<String, dynamic> json) {
    return BookingPercentageModel(
      customerPercentage: json['user_booking'],
      othersPercentage: json['other_booking'],
    );
  }
}
