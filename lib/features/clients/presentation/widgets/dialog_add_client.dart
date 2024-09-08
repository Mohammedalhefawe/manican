import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/custom_textfiled.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/features/clients/presentation/bloc/cubit.dart';
import 'package:manicann/features/clients/presentation/bloc/states.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/custom_toast.dart';

TextEditingController firstNameController = TextEditingController();
TextEditingController midNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
bool firstEditCall = true;

class AddClientDialog extends StatelessWidget {
  final bool isEdit;
  const AddClientDialog({
    super.key,
    required this.isEdit,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientsCubit, ClientsStates>(
        listener: (context, state) {
      if (state is AddClientSuccessState) {
        Navigator.pop(context);
      }
      if (state is EditClientSuccessState) {
        Navigator.pop(context);
      }
      if (state is EditClientNothingChangedState) {
        CustomToast t =
            const CustomToast(type: "Warning", msg: "لم يتم تغيير أي من القيم");
        t(context);
      }
    }, builder: (context, state) {
      var cubit = ClientsCubit.get(context);
      if (isEdit && cubit.selectedClientToEdit != null && firstEditCall) {
        firstNameController.text = cubit.selectedClientToEdit!.firstName ?? "";
        midNameController.text = cubit.selectedClientToEdit!.middleName ?? "";
        lastNameController.text = cubit.selectedClientToEdit!.lastName ?? "";
        phoneNumberController.text =
            cubit.selectedClientToEdit!.phoneNumber ?? "";
        firstEditCall = false;
      }
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        child: Container(
          width: 44.w,
          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 3.h),
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
                'إضافة زبون',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              RowForTwoTextFiled(
                hint1: "الاسم الأول",
                controller1: firstNameController,
                hint2: "اسم الأب",
                controller2: midNameController,
              ),
              SizedBox(height: 2.h),
              RowForTwoTextFiled(
                hint1: "العائلة",
                controller1: lastNameController,
                hint2: "رقم الهاتف",
                isDigit: true,
                controller2: phoneNumberController,
              ),
              SizedBox(height: 7.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myButton(
                      backgroundColor: mainYellowColor,
                      text: isEdit ? "تعديل" : "إضافة",
                      onPressed: () {
                        if (isEdit) {
                          cubit.editClient(
                            firstName: firstNameController.text,
                            middleName: midNameController.text,
                            lastName: lastNameController.text,
                            phoneNumber: phoneNumberController.text,
                          );
                        } else {
                          cubit.addClient(
                            firstName: firstNameController.text,
                            middleName: midNameController.text,
                            lastName: lastNameController.text,
                            phoneNumber: phoneNumberController.text,
                          );
                        }
                      }),
                  SizedBox(
                    width: 2.w,
                  ),
                  myButton(
                    backgroundColor: lightGrey,
                    text: "إلغاء",
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class RowForTwoTextFiled extends StatelessWidget {
  final String hint1;
  final String hint2;
  final bool? isDigit;
  final TextEditingController controller1;
  final TextEditingController controller2;

  const RowForTwoTextFiled({
    super.key,
    required this.hint1,
    required this.hint2,
    required this.controller1,
    required this.controller2,
    this.isDigit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CustomTextFiled(hintText: hint1, controller: controller1),
        ),
        SizedBox(width: 1.w),
        Expanded(
          child: CustomTextFiled(
            hintText: hint2,
            controller: controller2,
            isDigit: isDigit,
          ),
        ),
      ],
    );
  }
}
