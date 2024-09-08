
import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  const BookingModel({
    super.id,
    super.customerFirstName,
    super.customerLastName,
    super.day,
    super.date,
    super.time,
    super.endTime,
    super.serviceName,
    super.status,
    super.employeeId,
    super.employeeFirstName,
    super.employeeLastName,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json){
    return BookingModel(
      id: json['id'],
      day: json['day'],
      date: json['date'],
      time: json['time'],
      endTime: json['end_time'],
      status: json['status'],
      customerFirstName: json['customer'] != null ? json['customer']['first_name'] : null,
      customerLastName: json['customer'] != null ? json['customer']['last_name'] : null,
      employeeLastName: json['employee'] != null ? json['employee']['last_name'] : "الأحمد",
      employeeFirstName: json['employee'] != null ? json['employee']['first_name'] : "هبة",
      employeeId: json['employee'] != null ? json['employee']['id'] : null,
      serviceName: json['service'] != null ? json['service']['name'] : null,
    );
  }
}
