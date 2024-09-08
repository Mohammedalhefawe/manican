import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ServiceEntity extends Equatable {
  int id;
  String name;

  ServiceEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  @override
  bool operator ==(Object other) {
    if(other is ServiceEntity){
      return id == other.id;
    }
    return false;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

}