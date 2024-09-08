import 'package:equatable/equatable.dart';

class BookingPercentage extends Equatable{
  final double? customerPercentage;
  final double? othersPercentage;

  const BookingPercentage({required this.customerPercentage, required this.othersPercentage});

  @override
  List<Object?> get props => [customerPercentage, othersPercentage];
}