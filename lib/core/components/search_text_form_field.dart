import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/font_styles.dart';


Widget searchFieldBuilder({
  required String hintText,
  required void Function(String)? onChanged,
  double borderRadius = 10,
  double elevation = 5,
  double width = 200,
  double height = 40,
  double contentPadding = 0,
  Color bgColor = lightGrey
}) {
  return Material(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    elevation: elevation,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: bgColor,
          hintText: hintText,
          contentPadding: EdgeInsets.all(contentPadding),
          hintStyle: defaultFontStyle,
          prefixIcon: const Padding(
            padding: EdgeInsetsDirectional.only(start: 10.0),
            child: Icon(
              Icons.search,
              color: blackColor,
              size: 24,
            ), // myIcon is a 48px-wide widget.
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide.none, // This removes the underline
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide.none, // This removes the underline
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            borderSide: BorderSide.none, // This removes the underline
          ),
        ),
        onChanged: onChanged,
        style: defaultFontStyle,
      ),
    ),
  );
}