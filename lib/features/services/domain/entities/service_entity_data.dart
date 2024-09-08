import 'dart:typed_data';

// ignore: must_be_immutable
class ServiceEntityData {
  final String name;
  final String period;
  final String price;
  final String from;
  final String to;
  final Uint8List? image;
  final String? filePath;
  final String branchId;

  ServiceEntityData({
    required this.branchId,
    required this.name,
    required this.period,
    required this.price,
    required this.from,
    required this.to,
    required this.image,
    required this.filePath,
  });
}
