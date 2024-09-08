class BeforeAfterModel {
  final int id;
  final int beforeId;
  final int afterId;
  final String? description;
  final int reactionsCount;
  final ImageDetails? before;
  final ImageDetails? after;

  BeforeAfterModel({
    required this.id,
    required this.beforeId,
    required this.afterId,
    required this.description,
    required this.reactionsCount,
    this.before,
    this.after,
  });

  // From JSON
  factory BeforeAfterModel.fromJson(Map<String, dynamic> json) {
    return BeforeAfterModel(
      id: json['id'],
      beforeId: json['before_id'],
      afterId: json['after_id'],
      description: json['description'] ?? "description",
      reactionsCount: json['reactions_count'],
      before:
          json['before'] != null ? ImageDetails.fromJson(json['before']) : null,
      after:
          json['after'] != null ? ImageDetails.fromJson(json['after']) : null,
    );
  }
}

class ImageDetails {
  final int id;
  final String imageableType;
  final int imageableId;
  final String image;
  final String type;

  ImageDetails({
    required this.id,
    required this.imageableType,
    required this.imageableId,
    required this.image,
    required this.type,
  });

  // From JSON
  factory ImageDetails.fromJson(Map<String, dynamic> json) {
    return ImageDetails(
      id: json['id'],
      imageableType: json['imageable_type'],
      imageableId: json['imageable_id'],
      image: json['image'],
      type: json['type'],
    );
  }
}
