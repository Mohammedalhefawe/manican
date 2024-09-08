import 'package:flutter/material.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),

              SizedBox(
                  height: 10.h,
                  child: const Icon(
                    Icons.error_outline,
                    size: 100,
                    color: Colors.red,
                  )),
              SizedBox(height: 5.h),
              const Text(
                '!! حدث خطأ ',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cairo"),
              ),
              // const SizedBox(height: 10),
              // Text(
              //   errorMessage,
              //   textAlign: TextAlign.center,
              //   maxLines: 3,
              //   style: const TextStyle(fontSize: 14, fontFamily: "Cairo"),
              // ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  myButton(
                      backgroundColor: Colors.red,
                      text: 'عودة  إلى التطبيق',
                      textColor: whiteColor,
                      hasBorder: false,
                      onPressed: () {
                        var appCubit = AppCubit.get(context);
                        appCubit.updateSelected(0);
                        appCubit.emit(ScreenNavigationState());
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
