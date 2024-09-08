
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

Widget myDropDownMenuButton({
  required Color borderColor,
  required void Function(Text? text)? onChanged,
  required Text? value,
  required List<DropdownMenuItem<Text>> testList,
  String fontFamily = "Cairo",
  FontWeight fontWeight = FontWeight.w600,
  double fontSize = 11.0,
  Color textColor = blackColor,
  double borderRadius = 10.0,
  double height = 40.0,
  double width = 125.0,
  double horizontalPadding = 8.0,
  double verticalPadding = 4.0,
  double elevation = 0,
}) {

  return Material(
    borderRadius: BorderRadiusDirectional.circular(borderRadius + 1),
    elevation: elevation,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(borderRadius + 1),
        color: mainYellowColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          width: width - 2,
          height: height - 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(borderRadius),
            color: whiteColor,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              padding: const EdgeInsetsDirectional.only(start: 10, end: 8),
              items: testList,
              onChanged: onChanged,
              borderRadius: BorderRadius.circular(borderRadius),
              style: TextStyle(
                color: blackColor,
                fontFamily: fontFamily,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
              alignment: AlignmentDirectional.centerStart,
              icon: const Row(
                children: [
                  SizedBox(
                    width: 2,
                  ),
                  Icon(Icons.arrow_drop_down, size: 24, color: mainYellowColor),
                ],
              ),
              value: value,
              dropdownColor: lightGrey,
              hint: Text(
                testList[0].value!.data!,
                style: TextStyle(
                  color: blackColor,
                  fontFamily: fontFamily,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
