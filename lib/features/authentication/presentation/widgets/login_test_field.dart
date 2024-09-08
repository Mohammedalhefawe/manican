import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/font_styles.dart';

Widget loginTextFormField({
  required TextEditingController controller,
  TextInputType? keyboardType,
  required String hintText,
  required String labelText,
  IconData? prefix,
  Color mainColor = blackColor,
  Color offColor = blackColor,
  Color suffixColor = mainYellowColor,
  Color errorColor = errorColor,
  bool isPassword = false,
  double radiusBorder = 10.0,
  IconData? suffix,
  void Function()? showPass,
  void Function(String)? onSubmit,
  void Function(String)? onChanged,
  String? Function(String?)? validate,
  void Function()? onTap,
  int? maxLines = 1,
}) =>
    Material(
      color: Colors.white,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: mainColor,
        obscureText: isPassword,
        onChanged: onChanged,
        onFieldSubmitted: onSubmit,
        validator: validate,
        maxLines: maxLines,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: "Cairo"),
        decoration: InputDecoration(
          constraints: const BoxConstraints(minHeight: 60),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: offColor, width: 1.5),
            borderRadius: BorderRadius.circular(radiusBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1.5),
            borderRadius: BorderRadius.circular(radiusBorder),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorColor, width: 1.5),
            borderRadius: BorderRadius.circular(radiusBorder),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1.5),
            borderRadius: BorderRadius.circular(radiusBorder),
          ),
          errorStyle: TextStyle(color: errorColor, fontFamily: "Cairo"),
          hintText: hintText,
          labelText: labelText,

          labelStyle: defaultFontStyle,
          prefixIcon: Icon(
            prefix,
            color: offColor,
            //size: 24,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: showPass,
                  icon: Icon(suffix),
                  color: isPassword ? offColor : suffixColor,
                )
              : null,
          //contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
        ),
        onTap: onTap,
      ),
    );
