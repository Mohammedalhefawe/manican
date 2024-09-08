import '../../domain/entities/service.dart';

// ignore: must_be_immutable
class ServiceModel extends ServiceEntity {
  ServiceModel(
      {required super.id,
        required super.name,
        });
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
