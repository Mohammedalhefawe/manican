import 'dart:typed_data';

// ignore: must_be_immutable
class BeforeAfterEntityData {
  final String description;
  final String? filePathBefore;
  final Uint8List? imageBefore;
  final String? filePathAfter;
  final Uint8List? imageAfter;

  BeforeAfterEntityData(
      {required this.description,
      required this.filePathBefore,
      required this.imageBefore,
      required this.filePathAfter,
      required this.imageAfter});
}
