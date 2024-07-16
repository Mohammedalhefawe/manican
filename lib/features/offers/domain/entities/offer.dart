import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final int id;
  final String title;
  final String description;
  final String image;
  final String date;

  const Offer(
    this.id, {
    required this.title,
    required this.description,
    required this.image,
    required this.date,
  });

  @override
  List<Object?> get props => [id, title, description, image, date];
}
