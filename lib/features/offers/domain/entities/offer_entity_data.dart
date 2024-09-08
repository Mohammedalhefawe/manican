import 'dart:typed_data';

class OfferEntityData {
  final String? name;
  final String? description;
  final Uint8List? image;
  final String? filePath;

  OfferEntityData({
    required this.name,
    required this.description,
    required this.image,
    required this.filePath,
  });
}
