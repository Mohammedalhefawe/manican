import 'package:manican/features/offers/domain/entities/offer.dart';

class OfferModel extends Offer {
  const OfferModel(super.id,
      {required super.title,
      required super.description,
      required super.image,
      required super.date});

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      json['id'],
      title: json['title'],
      description: '',
      date: '',
      image: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'image': image
    };
  }
}
