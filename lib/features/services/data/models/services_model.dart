import 'package:manicann/features/services/domain/entities/service.dart';
import 'package:manicann/models.dart';

// ignore: must_be_immutable
class ServiceModel extends ServiceEntity {
  ServiceModel(
      {required super.id,
      required super.name,
      super.period,
      required super.price,
      required super.newPrice,
      required super.from,
      required super.to,
      required super.image});
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      period: json['period'],
      price: json['price'].toDouble(),
      newPrice: json['newPrice'].toDouble(),
      from: json['from'],
      to: json['to'],
      image: json['image'] != null ? ImageModel.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'period': period,
      'price': price,
      'from': from,
      'to': to,
    };
  }
}
