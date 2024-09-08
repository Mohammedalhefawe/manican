import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/custom_textfiled.dart';
import 'package:manicann/core/components/custom_textfiled_Time.dart';
import 'package:manicann/core/components/error_widget.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/core/function/validinput.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_cubit.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_state.dart';
import 'package:sizer/sizer.dart';

class AddServiceDialog extends StatelessWidget {
  final TextEditingController controllerNameService;
  final TextEditingController controllerPrice;
  final TextEditingController controllerPerioud;
  final void Function()? pickImage;
  final ServiceBloc bloc;
  final void Function()? onAdd;
  const AddServiceDialog(
      {super.key,
      this.pickImage,
      this.onAdd,
      required this.controllerNameService,
      required this.controllerPrice,
      required this.controllerPerioud,
      required this.bloc});

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
            child: Form(
              key: bloc.formstate,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'إضافة خدمة',
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    // height: 28.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              CustomTextFiledWithValidate(
                                  height: !bloc.isValid ? 60 : null,
                                  validator: (val) {
                                    return vaildator(val!, 3, 30, 'الاسم');
                                  },
                                  hintText: 'اسم الخدمة',
                                  controller: controllerNameService),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 7.w,
                                    child: CustomTextFiledForTime(
                                        height: !bloc.isValid ? 60 : null,
                                        validator: (val) {
                                          return vaildator(
                                              val!, 3, 30, 'الوقت');
                                        },
                                        onTap: () {
                                          bloc.selectStartTime(context);
                                        },
                                        hintText: 'وقت البدء',
                                        controller: TextEditingController(
                                            text: bloc.startTime ?? "")),
                                  ),
                                  SizedBox(
                                    width: 0.5.w,
                                  ),
                                  SizedBox(
                                    width: 7.w,
                                    child: CustomTextFiledForTime(
                                        height: !bloc.isValid ? 60 : null,
                                        validator: (val) {
                                          return vaildator(
                                              val!, 3, 30, 'الوقت');
                                        },
                                        onTap: () {
                                          bloc.selectEndTime(context);
                                        },
                                        hintText: 'وقت الانتهاء',
                                        controller: TextEditingController(
                                            text: bloc.endTime ?? "")),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 7.w,
                                    child: CustomTextFiledWithValidate(
                                        height: !bloc.isValid ? 60 : null,
                                        validator: (val) {
                                          return vaildator(
                                              val!, 1, 5, 'الفترة');
                                        },
                                        isDigit: true,
                                        hintText: 'الفترة (د)',
                                        controller: controllerPerioud),
                                  ),
                                  SizedBox(
                                    width: 0.5.w,
                                  ),
                                  SizedBox(
                                    width: 7.w,
                                    child: CustomTextFiledWithValidate(
                                        height: !bloc.isValid ? 60 : null,
                                        validator: (val) {
                                          return vaildator(
                                              val!, 1, 30, 'السعر');
                                        },
                                        isDigit: true,
                                        hintText: 'السعر',
                                        controller: controllerPrice),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: InkWell(
                            onTap: pickImage,
                            child: Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        bloc.selecetImage == false ? 4.h : 0),
                                height: 33.h,
                                width: 10.w,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 234, 235, 238),
                                    borderRadius: BorderRadius.circular(10)),
                                child: bloc.selecetImage == true
                                    ? Image.memory(
                                        bloc.webImage,
                                        fit: BoxFit.cover,
                                      )
                                    : Center(
                                        child: Container(
                                          height: 8.h,
                                          width: 3.5.w,
                                          decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: const Icon(
                                            Icons.add,
                                            size: 45,
                                            color: Color.fromARGB(
                                                255, 234, 235, 238),
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
            ),
          );
        }
      },
    );
  }
}
