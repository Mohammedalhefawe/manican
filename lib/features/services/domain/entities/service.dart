import 'package:equatable/equatable.dart';
import 'package:manicann/models.dart';

// ignore: must_be_immutable
class ServiceEntity extends Equatable {
  int id;
  String name;
  int? period;
  double price;
  double newPrice;
  String from;
  String to;
  ImageModel? image;

  ServiceEntity({
    required this.id,
    required this.name,
    this.period,
    required this.price,
    required this.newPrice,
    required this.from,
    required this.to,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, period, price, newPrice, from, to];
}
