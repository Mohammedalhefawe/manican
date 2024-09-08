import 'package:flutter/material.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/core/theme/font_styles.dart';
import 'package:manicann/features/booking/data/models/Services_employee_Model.dart';
import 'package:manicann/features/booking/data/models/users_model.dart';
import 'package:sizer/sizer.dart';

class CustomDropDownButtonAsTextFiled extends StatelessWidget {
  final List listData;
  final String hintText;
  final void Function(Object?)? onChanged;
  final isSelected;
  const CustomDropDownButtonAsTextFiled({
    super.key,
    required this.listData,
    required this.hintText,
    this.isSelected,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    print(listData.length);
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
        Container(
          alignment: Alignment.centerLeft,
          height: 6.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: lightGrey),
          ),
          child: PopupMenuButton<dynamic>(
            offset: Offset(0, 6.h),
            constraints: BoxConstraints(
              minWidth: 7.w,
              maxWidth: 15.w,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            itemBuilder: (BuildContext context) {
              return listData.map((item) {
                return PopupMenuItem(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: item.runtimeType == Service
                        ? Text(
                            item.name,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          )
                        : item.runtimeType == Employee
                            ? Text(
                                item.firstName + " " + item.lastName,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                              )
                            : item.runtimeType == UserModel
                                ? Text(
                                    item.firstName + " " + item.lastName,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  )
                                : const Text(
                                    'None',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                  ),
                );
              }).toList();
            },
            onSelected: (value) {
              if (onChanged != null) {
                print("================== ${value.id}");
                onChanged!(value);
              }
            },
            child: Container(
              padding: EdgeInsetsDirectional.only(start: 1.w, end: 1.w),
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
        ),
      ],
    );
  }
}
