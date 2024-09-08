import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// the label of each page which exists at the top left the main page near the sidebar

Widget pageLabelBuilder({
  required String label,
  String fontFamily = "Cairo",
  FontWeight fontWeight = FontWeight.w800,
  double fontSize = 24.0,
  Color textColor = blackColor,
}) {
  return Text(
    label,
    style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}