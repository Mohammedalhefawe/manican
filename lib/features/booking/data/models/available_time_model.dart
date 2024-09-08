class AvailableTimeModel {
  String from;
  String to;

  AvailableTimeModel({
    required this.from,
    required this.to,
  });

  factory AvailableTimeModel.fromJson(Map<String, dynamic> json) {
    return AvailableTimeModel(
      from: json['from'],
      to: json['to'],
    );
  }
}
