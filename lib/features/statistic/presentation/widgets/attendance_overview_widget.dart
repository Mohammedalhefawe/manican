import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manicann/core/components/custom_cache_image.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/function/time_formatter.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/features/statistic/presentation/bloc/statistic_bloc/statistic_bloc.dart';
import 'package:sizer/sizer.dart';

class AttendanceOverview extends StatelessWidget {
  final StatisticBloc bloc;
  const AttendanceOverview({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildHeader(
              viewAll: () {
                bloc.viewAll();
              },
              bloc: bloc),
          SizedBox(height: 2.5.h),
          buildTableHeader(),
          Divider(
            color: Colors.grey.shade100,
            height: 0.1.h,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: ListView.builder(
              key: ValueKey<bool>(bloc.isViewAll),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: bloc.isViewAll
                  ? bloc.dataAttendanceInfo.length
                  : (bloc.dataAttendanceInfo.length > 5
                      ? 5
                      : bloc.dataAttendanceInfo.length),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    buildTableRow(
                      imageUrl:
                          bloc.dataAttendanceInfo[index].profileImage?.image,
                      name: bloc.dataAttendanceInfo[index].firstName ??
                          "غير معروف",
                      designation:
                          bloc.dataAttendanceInfo[index].role ?? "غير معروف",
                      checkInTime:
                          (bloc.dataAttendanceInfo[index].allAttendance.isEmpty)
                              ? "غير معروف"
                              : bloc.dataAttendanceInfo[index].allAttendance[0]
                                          .checkIn !=
                                      null
                                  ? formatArabicTimeEdit(bloc
                                      .dataAttendanceInfo[index]
                                      .allAttendance[0]
                                      .checkIn!)
                                  : "غير معروف",
                      status:
                          (bloc.dataAttendanceInfo[index].allAttendance.isEmpty)
                              ? false
                              : bloc.dataAttendanceInfo[index].allAttendance[0]
                                      .status !=
                                  'attended',
                    ),
                    Divider(
                      color: Colors.grey.shade100,
                      height: 0.1.h,
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget buildHeader({required viewAll, required StatisticBloc bloc}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'الحضور اليومي',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      OutlinedButton(
        onPressed: viewAll,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.primary),
        ),
        child: Text(bloc.isViewAll ? 'استعراض أقل' : 'استعراض أكثر'),
      ),
    ],
  );
}

Widget buildTableHeader() {
  return Row(
    children: [
      Expanded(flex: 3, child: Text('اسم الموظف', style: headerStyle())),
      Expanded(flex: 2, child: Text('المسمى الوظيفي', style: headerStyle())),
      Expanded(flex: 2, child: Text('وقت الدخول', style: headerStyle())),
      Expanded(flex: 1, child: Text('الحالة', style: headerStyle())),
    ],
  );
}

Widget buildTableRow(
    {required String? imageUrl,
    required String name,
    required String designation,
    required String checkInTime,
    required bool status}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Expanded(
            flex: 3,
            child: CircleImageWithText(
              imageUrl: imageUrl != null
                  ? AppLink.imageBaseUrl + imageUrl
                  : "https://www.imparalingleseconmonica.com/wp-content/uploads/2017/09/man-business.jpg",
              text: name,
            )),
        Expanded(
            flex: 2,
            child: Text(
              designation,
              style: contentStyle(),
            )),
        Expanded(
            flex: 2,
            child: Text(
              checkInTime,
              style: contentStyle(),
            )),
        Expanded(
            flex: 1,
            child: AttendanceIndicator(
              isLate: status,
            )),
      ],
    ),
  );
}

TextStyle headerStyle() {
  return const TextStyle(
      fontSize: 16, color: Color.fromARGB(255, 162, 161, 168));
}

TextStyle contentStyle() {
  return TextStyle(
      fontSize: 16, color: AppColors.black, fontWeight: FontWeight.w300);
}

class CircleImageWithText extends StatelessWidget {
  final String imageUrl;
  final String text;

  const CircleImageWithText({
    super.key,
    required this.imageUrl,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 30,
          width: 30,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: CustomCacheImage(
            imageUrl: imageUrl,
            smallIcon: true,
          ),
        ),
        SizedBox(width: 1.w), // Adds some space between the image and text
        Text(
          text,
          style: contentStyle(),
        ),
      ],
    );
  }
}

class AttendanceIndicator extends StatelessWidget {
  final bool isLate;

  const AttendanceIndicator({super.key, required this.isLate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 3.w),
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isLate
            ? const Color.fromRGBO(244, 91, 105, 0.1)
            : const Color.fromRGBO(63, 194, 138, 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          isLate ? 'غائب' : 'حاضر',
          style: TextStyle(
            color: isLate
                ? const Color.fromRGBO(244, 91, 105, 1)
                : const Color.fromRGBO(63, 194, 138, 1),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
