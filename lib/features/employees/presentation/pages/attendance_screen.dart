import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/components/drop_down_button.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/employees/domain/entities/attendance.dart';
import 'package:manicann/features/employees/presentation/bloc/cubit.dart';
import 'package:manicann/features/employees/presentation/bloc/states.dart';
import 'package:manicann/features/employees/presentation/pages/employees_screen.dart';
import '../../../../core/components/custom_table.dart';
import '../../../../core/components/dashboard_builder.dart';
import '../../../../core/components/page_label.dart';
import '../../../../core/theme/app_colors.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = max(MediaQuery.of(context).size.width, 1000);
    double screenHeight = max(MediaQuery.of(context).size.height, 650);
    double sideBarWidth = 210;
    return BlocConsumer<EmployeesCubit, EmployeesStates>(
      listener: (context, state) {
        if (state is GetEmployeeAttendanceErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
      },
      builder: (context, state) {
        var cubit = EmployeesCubit.get(context);

        Widget pageContent = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60),
          child: ConditionalBuilder(
            condition: state is! GetEmployeeAttendanceLoadingState,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      var appCubit = AppCubit.get(context);
                      int indx = AppLink.role == 'admin' ? 2 : 1;
                      appCubit.screens[indx] = const EmployeesScreen();
                      appCubit.emit(ScreenNavigationState());
                    },
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      color: blackColor,
                      size: 20,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    pageLabelBuilder(label: "سجل حضور الموظف: "),
                    pageLabelBuilder(
                        label:
                            "${cubit.detailsEmployee?.firstName} ${cubit.detailsEmployee?.middleName} ${cubit.detailsEmployee?.lastName}"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    myDropDownMenuButton(
                      borderColor: mainYellowColor,
                      testList: cubit.attendanceFilterTypes,
                      onChanged: (Text? text) {
                        cubit.changeAttendanceTableFilter(text);
                      },
                      value: cubit.attendanceTableFilterType,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTable<Attendance>(
                  list: cubit.attendanceList,
                  type: "Attendance",
                  pageIndex: cubit.attendanceTablePageIndex,
                  changeTablePage: (int newPage) =>
                      cubit.changeAttendanceTablePage(newPage),
                  numColumns: 5,
                  labels: const [
                    'اليوم',
                    'التاريخ',
                    'وقت الحضور',
                    'وقت المغادرة',
                    'الحالة',
                  ],
                  flexes: const [3, 3, 3, 2, 1],
                  sizedBoxesWidth: const [25, 25, 25, 25],
                  tableFunctions: const [],
                ),
              ],
            ),
            fallback: (context) => const Center(child: LoadingWidget()),
          ),
        );

        return DashboardPageBuilder(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          sideBarWidth: sideBarWidth,
          pageContent: pageContent,
          isLogin: false,
        );
      },
    );
  }
}
