import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomDropDownButton extends StatelessWidget {
  final List listData;
  final String hintText;
  final void Function(Object?)? onChanged;
  final isSelected;
  const CustomDropDownButton({
    super.key,
    required this.listData,
    required this.hintText,
    this.isSelected,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 6.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: PopupMenuButton<String>(
        offset: Offset(0, 6.h),
        constraints: BoxConstraints(
          minWidth: 7.w,
          maxWidth: 15.w,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        itemBuilder: (BuildContext context) {
          return listData.map((item) {
            return PopupMenuItem<String>(
              value: item,
              child: Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Text(
                  item,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
            );
          }).toList();
        },
        onSelected: (String value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        child: Container(
          padding: EdgeInsetsDirectional.only(start: 3.5.w, end: 1.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isSelected ?? hintText,
              ),
              const Icon(
                Icons.expand_more_rounded,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
