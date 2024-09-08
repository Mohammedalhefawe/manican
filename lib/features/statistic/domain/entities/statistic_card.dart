import 'package:flutter/material.dart';

class StatisticCardModel {
  final IconData icon;
  final String title;
  final String number;
  final String updateText;
  final String percent;
  final bool isIncrement;

  StatisticCardModel(
      {required this.icon,
      required this.title,
      required this.number,
      required this.updateText,
      required this.percent,
      required this.isIncrement});
}
