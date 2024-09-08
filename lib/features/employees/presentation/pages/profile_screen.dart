import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/constance/appLink.dart';

import 'package:manicann/features/customer/presentation/widgets/top_profile.dart';
import 'package:manicann/features/employees/presentation/bloc/cubit.dart';
import 'package:manicann/features/employees/presentation/bloc/states.dart';
import 'package:manicann/features/employees/presentation/pages/attendance_screen.dart';
import 'package:manicann/shared_screen/main_layout_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constance/appImgaeAsset.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/statistics.dart';

class ProfileScreen extends StatelessWidget {
  final double rate;
  final int numOfServeces;
  final String? image;
  final List dataLabel;
  final List dataValue;
  final List<double> sectionsVal;
  final List<String> sectionsName;
  final List<Color> colors;

  const ProfileScreen(
      {super.key,
      required this.rate,
      required this.numOfServeces,
      this.image,
      required this.dataLabel,
      required this.dataValue,
      required this.sectionsVal,
      required this.sectionsName,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeesCubit, EmployeesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = EmployeesCubit.get(context);
          Widget pageContent;
          pageContent = Scaffold(
              backgroundColor: Colors.transparent,
              body: Row(
                children: [
                  Container(
                    height: 100.h,
                    width: MediaQuery.of(context).size.width - 210,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 30.h,
                                      width: MediaQuery.of(context).size.width -
                                          210,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: const BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.only(
                                          topStart: Radius.circular(45),
                                        ),
                                      ),
                                      child: CustomPaint(
                                        size: Size(
                                          MediaQuery.of(context).size.width -
                                              210,
                                          30.h,
                                        ),
                                        painter: RPSCustomPainter(),
                                      ),
                                    ),
                                    Container(
                                      height: 30.h,
                                      width: MediaQuery.of(context).size.width -
                                          210,
                                      decoration: const BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadiusDirectional.only(
                                          topStart: Radius.circular(45),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadiusDirectional.only(
                                          topStart: Radius.circular(45),
                                        ),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 1, sigmaY: 1),
                                          child: Container(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            PositionedDirectional(
                              bottom: -16.h,
                              start: 2.w,
                              child: Container(
                                height: 15.w,
                                width: 15.w,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                // ignore: sort_child_properties_last
                                child: image != null
                                    ? Image.network(
                                        AppLink.imageBaseUrl + image!,
                                        fit: BoxFit.cover,
                                        height: 15.w,
                                        width: 15.w,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              AppImageAsset.defaultUserImage);
                                        },
                                      )
                                    : Image.asset(
                                        AppImageAsset.defaultUserImage),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.w),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        RoeDataForProfile(
                            dataLabel: dataLabel,
                            dataValue: dataValue,
                            sectionsVal: sectionsVal,
                            sectionsName: sectionsName,
                            colors: colors),
                        // SizedBox(
                        //   height: 5.h,
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              myButton(
                                backgroundColor: mainYellowColor,
                                text: "تحميل تقرير الموظف",
                                onPressed: () {
                                  if (cubit.detailsEmployee!.id != null) {
                                    cubit.getReportEmployee(
                                        cubit.detailsEmployee!.id.toString(),
                                        context);
                                  } else {
                                    CustomToast t = const CustomToast(
                                        type: "Error",
                                        msg: "حدث خطأ غير متوقع أعد المحاولة");
                                    t(context);
                                  }
                                },
                              ),
                              const SizedBox(width: 30),
                              myButton(
                                backgroundColor: mainYellowColor,
                                text: "عرض سجل الحضور",
                                onPressed: () {
                                  if (cubit.detailsEmployee!.id != null) {
                                    cubit.getEmployeeAttendance(
                                        employeeId: cubit.detailsEmployee!.id!);
                                  } else {
                                    CustomToast t = const CustomToast(
                                        type: "Error",
                                        msg: "حدث خطأ غير متوقع أعد المحاولة");
                                    t(context);
                                  }
                                  var appCubit = AppCubit.get(context);
                                  int indx = AppLink.role == 'admin' ? 2 : 1;
                                  appCubit.screens[indx] =
                                      const AttendanceScreen();
                                  appCubit.emit(ScreenNavigationState());
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));

          return MainLayoutScreen(
            pageContent: pageContent,
          );
        });
  }
}

class RoeDataForProfile extends StatelessWidget {
  const RoeDataForProfile({
    super.key,
    required this.dataLabel,
    required this.dataValue,
    required this.sectionsVal,
    required this.sectionsName,
    required this.colors,
  });

  final List dataLabel;
  final List dataValue;
  final List<double> sectionsVal;
  final List<String> sectionsName;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Row(
              children: List.generate(
                dataLabel.length,
                (i) {
                  return Column(
                    children: List.generate(dataLabel[i].length, (j) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 20.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      height: 11.h,
                                      width: 0.15.w,
                                      color: AppColors.primary,
                                    ),
                                    const CircleAvatar(
                                      radius: 4,
                                      backgroundColor: Colors.blueGrey,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${dataLabel[i][j]} : ",
                                      style: appTheme.textTheme.titleLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                      child: Text(
                                        " ${dataValue[i][j]}",
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: appTheme.textTheme.titleLarge!
                                            .copyWith(
                                                // height: 0.1,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(bottom: 6.h),
            height: 50.h,
            width: 40.w,
            child: StatisticsWidget(
              sectionsVal: sectionsVal,
              sectionsName: sectionsName,
              colors: colors,
            ),
          ),
        ),
      ],
    );
  }
}
