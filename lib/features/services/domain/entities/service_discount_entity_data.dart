// ignore: must_be_immutable
class ServiceDiscountEntity {
  List<int> services;
  String value;
  String to;
  String from;

  ServiceDiscountEntity({
    required this.services,
    required this.value,
    required this.to,
    required this.from,
  });
}
