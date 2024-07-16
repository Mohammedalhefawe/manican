import 'package:flutter/material.dart';
import 'package:manican/core/components/custom_textfiled.dart';
import 'package:manican/core/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class AddServiceDialog extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function()? addImage;
  final onCancel;
  final onAdd;
  const AddServiceDialog(
      {super.key,
      required this.controller,
      required this.hintText,
      this.addImage,
      this.onCancel,
      this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.red,
      child: buildDialogContent(context),
    );
  }

  Widget buildDialogContent(BuildContext context) {
    return Container(
      width: 40.w,
      padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Add Service',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: 28.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomTextFiled(
                      hintText: hintText, controller: controller),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: InkWell(
                    onTap: addImage,
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        height: 33.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 234, 235, 238),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Container(
                            height: 8.h,
                            width: 3.5.w,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(4)),
                            child: const Icon(
                              Icons.add,
                              size: 45,
                              color: Color.fromARGB(255, 234, 235, 238),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          SizedBox(
            height: 10.h,
            width: 100.w,
            child: Row(
              children: [
                //btn1
                //btn2
              ],
            ),
          ),
        ],
      ),
    );
  }
}
