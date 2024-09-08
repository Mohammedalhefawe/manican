import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class FileAttendanceEntity extends Equatable {
  final Uint8List? file;
  final String? filePath;

  const FileAttendanceEntity({required this.file, required this.filePath});

  @override
  List<Object?> get props => [file, file];
}

class DownloadFileEntity extends Equatable {
  final String date;
  final String? idEmployee;

  const DownloadFileEntity({required this.date, required this.idEmployee});

  @override
  List<Object?> get props => [date, idEmployee];
}
