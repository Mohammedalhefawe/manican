
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/font_styles.dart';

Widget checkBoxBuilder({
  required String boxLabel,
  required Function()? onTap,
  required bool isSelected,
  double boxSide = 18,
  boxBackgroundColor = lightGrey,
  double boxBorderRadius = 5,
  Color selectedIconColor = mainYellowColor,
  double spacer = 10,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: Stack(
              alignment: FractionalOffset.center,
              children: [
                Container(
                  height: boxSide,
                  width: boxSide,
                  decoration: BoxDecoration(
                    color: boxBackgroundColor,
                    borderRadius: BorderRadius.circular(boxBorderRadius),
                    border: Border.all(),
                  ),
                ),
                Icon(
                  Icons.check,
                  size: 28,
                  color:
                  isSelected ? selectedIconColor : Colors.transparent,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: spacer,
        ),
        Text(
          boxLabel,
          style: textFieldLabelStyle,
        ),
      ],
    );
