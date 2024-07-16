import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final double? borderRadius;
  final double? elevation;
  final double? width;
  final double? height;
  final double? contentPadding;
  const CustomTextFiled({
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
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Material(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
          child: Container(
            width: width ?? 100.w,
            height: height ?? 7.h,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
            ),
            child: TextFormField(
              validator: validator,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: contentPadding ?? 1.w),
                border: border,
                enabledBorder: border,
                focusedBorder: border,
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
