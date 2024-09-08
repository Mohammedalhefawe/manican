import 'package:equatable/equatable.dart';
import 'package:manicann/models.dart';

// ignore: must_be_immutable
class OfferEntity extends Equatable {
  int id;
  String title;
  String description;
  DateTime date;
  ImageModel? image;

  OfferEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.image,
  });

  @override
  List<Object?> get props => [id, title, description, image, date];
}
