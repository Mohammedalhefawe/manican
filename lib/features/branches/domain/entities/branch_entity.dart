import 'dart:io';
import 'dart:typed_data';

class BranchEntity {
  final String? name;
  final String? description;
  final String? location;
  final String? startTime;
  final String? endTime;
  final List<String> wokingDays;
  final Uint8List? image;
  final String? filePath;

  BranchEntity({
    required this.name,
    required this.description,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.wokingDays,
    required this.image,
    required this.filePath,
  });
}
