import 'package:flutter/material.dart';
import 'package:manican/core/components/custom_textfiled.dart';
import 'package:manican/features/customer/domain/entities/add_customer.dart';
import 'package:sizer/sizer.dart';

class AddCustomerDialog extends StatelessWidget {
  final AddCustomer addCustomer;
  const AddCustomerDialog({
    super.key,
    required this.addCustomer,
  });

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
      width: 44.w,
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
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
            'Add Customer',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
          RowForTowTextFiled(
            hint1: "First Name",
            controller1: addCustomer.firstName,
            hint2: "Mid Name",
            controller2: addCustomer.midName,
          ),
          SizedBox(height: 2.h),
          RowForTowTextFiled(
            hint1: "Last Name",
            controller1: addCustomer.lastName,
            hint2: "Phone Number",
            controller2: addCustomer.phoneNumber,
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              //btn1
              //btn2
            ],
          ),
        ],
      ),
    );
  }
}

class RowForTowTextFiled extends StatelessWidget {
  final String hint1;
  final String hint2;
  final TextEditingController controller1;
  final TextEditingController controller2;

  const RowForTowTextFiled({
    super.key,
    required this.hint1,
    required this.hint2,
    required this.controller1,
    required this.controller2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFiled(hintText: hint1, controller: controller1),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: CustomTextFiled(hintText: hint2, controller: controller2),
        ),
      ],
    );
  }
}
