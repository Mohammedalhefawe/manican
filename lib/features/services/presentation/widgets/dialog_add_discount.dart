import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/custom_textFiled_datePicker_as_textFiled.dart';
import 'package:manicann/core/components/custom_textfiled.dart';
import 'package:manicann/core/components/error_widget.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/core/function/validinput.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_cubit.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_state.dart';
import 'package:sizer/sizer.dart';

class AddDiscountDialog extends StatelessWidget {
  final TextEditingController controllerDiscount;
  final ServiceBloc bloc;
  final void Function()? onAdd;
  const AddDiscountDialog(
      {super.key,
      required this.bloc,
      required this.controllerDiscount,
      this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: Container(
          width: 40.w,
          constraints: BoxConstraints(maxHeight: 70.h),
          child: buildDialogContent(context)),
    );
  }

  Widget buildDialogContent(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, state) {
        if (state is ErrorServiceState) {
          return MyErrorWidget(
            text: state.message,
          );
        } else if (state is LoadingServiceState) {
          return const LoadingWidget();
        } else {
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
                  'إضافة خصم',
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  child: Expanded(
                    child: Form(
                      key: bloc.formstate,
                      child: Column(
                        children: [
                          CustomTextFiledWithValidate(
                              isDigit: true,
                              height: !bloc.isValid ? 60 : null,
                              validator: (val) {
                                return vaildator(val!, 1, 30, 'النسبة');
                              },
                              hintText: 'نسبة الخصم %',
                              controller: controllerDiscount),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDatePickerAsTextFiled(
                                  height: !bloc.isValid ? 60 : null,
                                  validator: (val) {
                                    return vaildator(val!, 1, 30, 'التاريخ');
                                  },
                                  hintText: 'تاريخ البدء',
                                  onChanged: (date) {
                                    bloc.startDate = date;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Expanded(
                                child: CustomDatePickerAsTextFiled(
                                  height: !bloc.isValid ? 60 : null,
                                  validator: (val) {
                                    return vaildator(val!, 1, 30, 'التاريخ');
                                  },
                                  hintText: 'تاريخ الانتهاء',
                                  onChanged: (date) {
                                    bloc.endDate = date;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  height: 10.h,
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      myButton(
                          width: 6.w,
                          height: 6.h,
                          elevation: 0,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          backgroundColor: AppColors.primary,
                          onPressed: onAdd,
                          text: 'إضافة'),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      myButton(
                          width: 6.w,
                          height: 6.h,
                          elevation: 0,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          backgroundColor: whiteColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          text: 'إلغاء'),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
