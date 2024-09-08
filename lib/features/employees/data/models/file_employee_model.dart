class FileResponseModel {
  final Original original;

  FileResponseModel({
    required this.original,
  });

  factory FileResponseModel.fromJson(Map<String, dynamic> json) {
    return FileResponseModel(
      original: Original.fromJson(json['original'] ?? {}),
    );
  }
}

class Original {
  final String? fileUrl;

  Original({
    this.fileUrl = '',
  });

  factory Original.fromJson(Map<String, dynamic> json) {
    return Original(
      fileUrl: json['file_url'] as String?,
    );
  }
}
