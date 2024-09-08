import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/core/theme/font_styles.dart';
import 'package:sizer/sizer.dart';

class CustomTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final double? borderRadius;
  final double? elevation;
  final double? width;
  final double? height;
  final bool? isDigit;
  final double? contentPadding;
  final double? minConstraints;
  final bool? enabled;
  const CustomTextFiled(
      {super.key,
      required this.hintText,
      this.borderRadius,
      this.elevation,
      this.width,
      this.height,
      this.minConstraints,
      this.contentPadding,
      required this.controller,
      this.validator,
      this.enabled,
      this.isDigit});
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
            width: width ?? 200,
            height: height ?? 35,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
            ),
            child: TextFormField(
              validator: validator,
              controller: controller,
              keyboardType: isDigit == true ? TextInputType.number : null,
              inputFormatters: isDigit == true
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : [],
              decoration: InputDecoration(
                constraints: BoxConstraints(minHeight: minConstraints ?? 45),
                filled: true,
                fillColor: lightGrey,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: contentPadding ?? 7),
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                focusedErrorBorder: border,
                errorStyle: const TextStyle(fontSize: 0),
              ),
              enabled: enabled ?? true,
              style: headerTableTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextFiledWithValidate extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final double? borderRadius;
  final double? elevation;
  final double? width;
  final double? height;
  final bool? isDigit;
  final double? contentPadding;

  const CustomTextFiledWithValidate({
    super.key,
    required this.hintText,
    this.borderRadius,
    this.elevation,
    this.width,
    this.height,
    this.contentPadding,
    required this.controller,
    this.validator,
    this.isDigit,
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
              color: Colors.white,
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
            ),
            child: TextFormField(
              validator: validator,
              controller: controller,
              keyboardType: isDigit == true ? TextInputType.number : null,
              inputFormatters: isDigit == true
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : [],
              decoration: InputDecoration(
                // isDense: true,
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
