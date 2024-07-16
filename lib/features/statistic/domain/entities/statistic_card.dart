import 'package:flutter/material.dart';
class StatisticCard {
  final IconData icon;
  final String title;
  final String number;
  final String updateText;
  final String percent;
  final bool isIncrement;

  StatisticCard(
      {required this.icon,
      required this.title,
      required this.number,
      required this.updateText,
      required this.percent,
      required this.isIncrement});
}
