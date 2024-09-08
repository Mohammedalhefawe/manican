import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/custom_textfiled.dart';
import 'package:manicann/core/components/error_widget.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/core/function/validinput.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/core/theme/app_theme.dart';
import 'package:manicann/features/before_after/presentation/bloc/cubit/before_after_cubit.dart';
import 'package:manicann/features/before_after/presentation/bloc/cubit/before_after_state.dart';
import 'package:sizer/sizer.dart';

class AddBeforeAfterScreen extends StatelessWidget {
  const AddBeforeAfterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: Container(
        width: 50.w,
        constraints: BoxConstraints(maxHeight: 75.h),
        child: const ContentDialogAddBeforeAfter(),
      ),
    );
  }
}

class ContentDialogAddBeforeAfter extends StatelessWidget {
  const ContentDialogAddBeforeAfter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeforeAfterBloc, BeforeAfterState>(
      builder: (context, state) {
        BeforeAfterBloc bloc = BlocProvider.of<BeforeAfterBloc>(context);
        if (state is ErrorBeforeAfterState) {
          return MyErrorWidget(
            text: state.message,
            onTap: () {
              // bloc.getAllData();
            },
          );
        } else if (state is LoadingBeforeAfterState) {
          return const LoadingWidget();
        } else {
          return Container(
            width: 50.w,
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
                    'إضافة قبل وبعد',
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BeforeAfterImageWidget(
                              text: 'قبل',
                              onpickImage: () {
                                bloc.pickImage(true);
                              },
                              bloc: bloc,
                            ),
                            SizedBox(
                              height: 1.w,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 4.h,
                                ),
                                const Icon(Icons.arrow_forward_outlined),
                              ],
                            ),
                            SizedBox(
                              height: 3.w,
                            ),
                            BeforeAfterImageWidget(
                              text: 'بعد',
                              bloc: bloc,
                              onpickImage: () {
                                bloc.pickImage(false);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomTextFiledWithValidate(
                          height: !bloc.isValid ? 60 : null,
                          validator: (val) {
                            return vaildator(val!, 10, 159, 'name');
                          },
                          hintText: 'الوصف',
                          controller: bloc.controllerDiscription,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  RowButton(
                    onAdd: () {
                      bloc.addData(context);
                    },
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

class RowButton extends StatelessWidget {
  final void Function()? onAdd;

  const RowButton({
    super.key,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            text: 'إضافة',
          ),
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
            text: 'إلغاء',
          ),
        ],
      ),
    );
  }
}

class BeforeAfterImageWidget extends StatelessWidget {
  final String text;
  final void Function()? onpickImage;
  final BeforeAfterBloc bloc;

  const BeforeAfterImageWidget({
    super.key,
    required this.text,
    this.onpickImage,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 17.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: textTheme.titleLarge,
              ),
              const Icon(
                Icons.one_x_mobiledata,
              ),
              Icon(
                Icons.add,
                color: AppColors.primary,
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          InkWell(
            onTap: onpickImage,
            child: SizedBox(
              height: 28.h,
              width: 17.w,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: lightGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: bloc.selecetImageAfter && text == "بعد"
                    ? Image.memory(
                        bloc.webImageAfter,
                        fit: BoxFit.cover,
                      )
                    : bloc.selecetImageBefore && text == "قبل"
                        ? Image.memory(
                            bloc.webImageBefore,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 40,
                              color: Colors.grey.shade400,
                            ),
                          ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
