import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manican/core/theme/app_colors.dart';
import 'package:manican/features/statistic/presentation/bloc/attendance_bloc/attendance_bloc.dart';
import 'package:manican/features/statistic/presentation/bloc/attendance_bloc/attendance_state.dart';
import 'package:sizer/sizer.dart';

class AttendanceOverview extends StatelessWidget {
  const AttendanceOverview({super.key});

  // final List<Attendance> bloc.dataAttendanceInfo;
  // final void Function()? viewAll;
  // const AttendanceOverview(
  //     {super.key, required this.bloc.dataAttendanceInfo, this.viewAll});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
      if (state is ChangeElementInDropDownState) {}
    }, builder: (context, state) {
      var bloc = BlocProvider.of<AttendanceBloc>(context);
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
            ListView.builder(
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
                        imageUrl: bloc.dataAttendanceInfo[index].imageUrl,
                        name: bloc.dataAttendanceInfo[index].name,
                        designation: bloc.dataAttendanceInfo[index].designation,
                        checkInTime: bloc.dataAttendanceInfo[index].checkInTime,
                        status: bloc.dataAttendanceInfo[index].status),
                    Divider(
                      color: Colors.grey.shade100,
                      height: 0.1.h,
                    ),
                  ],
                );
              },
            )

            // Add more rows as needed
          ],
        ),
      );
    });
  }
}

Widget buildHeader({required viewAll, required AttendanceBloc bloc}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Attendance Overview',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          )),
      OutlinedButton(
        onPressed: viewAll,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.primary),
        ),
        child: Text(bloc.isViewAll ? 'View Less' : 'View All'),
      ),
    ],
  );
}

Widget buildTableHeader() {
  return Row(
    children: [
      Expanded(flex: 3, child: Text('Employee Name', style: headerStyle())),
      Expanded(flex: 2, child: Text('Designation', style: headerStyle())),
      Expanded(flex: 2, child: Text('Check In Time', style: headerStyle())),
      Expanded(flex: 1, child: Text('Status', style: headerStyle())),
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
              imageUrl: imageUrl ??
                  "https://cdn.fstoppers.com/styles/full/s3/media/2017/09/10/1_use_psychology_to_take_better_photographs.jpeg",
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
  return GoogleFonts.lexend(
      fontSize: 16, color: const Color.fromARGB(255, 162, 161, 168));
}

TextStyle contentStyle() {
  return GoogleFonts.lexend(
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
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(imageUrl),
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
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isLate
            ? const Color.fromRGBO(244, 91, 105, 0.1)
            : const Color.fromRGBO(63, 194, 138, 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          isLate ? 'Late' : 'On Time',
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
