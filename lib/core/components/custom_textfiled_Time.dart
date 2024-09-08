import 'package:flutter/material.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/core/theme/font_styles.dart';
import 'package:sizer/sizer.dart';

class CustomTextFiledForTime extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final String hintText;
  final double? borderRadius;
  final double? elevation;
  final double? width;
  final double? height;
  final double? contentPadding;
  const CustomTextFiledForTime({
    super.key,
    required this.hintText,
    this.borderRadius,
    this.elevation,
    this.width,
    this.height,
    this.contentPadding,
    required this.controller,
    this.validator,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
      borderSide: BorderSide.none,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: textFieldLabelStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        Material(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
          child: Container(
            width: width ?? 50.w,
            height: height ?? 35,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
            ),
            child: TextFormField(
              onTap: onTap,
              validator: validator,
              readOnly: true,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: lightGrey,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: contentPadding ?? 7),
                border: border,
                enabledBorder: border,
                focusedBorder: border,
              ),
              style: textFromStyle,
            ),
          ),
        ),
      ],
    );
  }
}

/*
class CustomServiceSelector extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final double? borderRadius;
  final double? elevation;
  final double? width;
  final double? height;
  final double? contentPadding;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final Function()? onPressed;
  final List<ServiceModel> services;

  const CustomServiceSelector({
    super.key,
    required this.hintText,
    this.borderRadius,
    this.elevation,
    this.width,
    this.height,
    this.contentPadding,
    required this.controller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
      borderSide: BorderSide.none,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: textFieldLabelStyle,
        ),
        SizedBox(
          height: 5,
        ),
        Material(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
          child: Container(
            width: width ?? 200,
            height: height ?? 35,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(borderRadius ?? 10)),
            ),
            child: TextFormField(
              validator: validator,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: lightGrey,
                contentPadding: EdgeInsets.symmetric(horizontal: contentPadding ?? 7),
                border: border,
                enabledBorder: border,
                focusedBorder: border,

              ),
              style: defaultFontStyle,
            ),
          ),
        ),
      ],
    );
  }
}*/
