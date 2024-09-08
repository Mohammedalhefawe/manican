import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/components/delete_dialog.dart';
import 'package:manicann/core/components/drop_down_button.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/employees/presentation/bloc/cubit.dart';
import 'package:manicann/features/employees/presentation/bloc/states.dart';
import 'package:manicann/features/employees/presentation/pages/add_employee_screen.dart';
import 'package:manicann/features/employees/presentation/pages/profile_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/custom_table.dart';
import '../../../../core/components/dashboard_builder.dart';
import '../../../../core/components/page_label.dart';
import '../../../../core/components/search_text_form_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/employee.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = max(MediaQuery.of(context).size.width, 1000);
    double screenHeight = max(MediaQuery.of(context).size.height, 650);
    double sideBarWidth = 210;
    return BlocConsumer<EmployeesCubit, EmployeesStates>(
      listener: (context, state) {
        if (state is GetEmployeesErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
        if (state is ReportEmployeeErrorState) {
          CustomToast t = const CustomToast(
              type: "Error",
              msg: 'حدث خطأ إثناء فتح التقرير , أعد المحاولة لاحقاً');
          t(context);
        }
        if (state is DeleteEmployeeErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
        if (state is DeleteEmployeeSuccessState) {
          CustomToast t =
              const CustomToast(type: "Success", msg: "تم حذف الموظف بنجاح");
          t(context);
        }

        if (state is EmployeeToEditSelectionState) {
          // navigateTo(
          //     context,
          //     AddEmployeeScreen(
          //       isEdit: true,
          //     ));
          var cubit = AppCubit.get(context);
          if (AppLink.role == 'admin') {
            cubit.screens[2] = AddEmployeeScreen(
              isEdit: true,
            );
          } else {
            cubit.screens[1] = AddEmployeeScreen(
              isEdit: true,
            );
          }
          cubit.emit(ScreenNavigationState());
        }
      },
      builder: (context, state) {
        var cubit = EmployeesCubit.get(context);

        Widget pageContent = Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 4.h),
          child: ConditionalBuilder(
            condition: state is! GetEmployeesLoadingState,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pageLabelBuilder(label: "الموظفين"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    searchFieldBuilder(
                      hintText: "ابحث هنا...",
                      onChanged: (String value) {
                        cubit.searchInList(value);
                      },
                      contentPadding: 14,
                    ),
                    const SizedBox(width: 30),
                    myDropDownMenuButton(
                      borderColor: mainYellowColor,
                      testList: cubit.employeesFilterTypes,
                      onChanged: (Text? text) {
                        cubit.changeEmployeesTableFilter(text);
                      },
                      value: cubit.employeesTableFilterType,
                    ),
                    const Spacer(),
                    myButton(
                      backgroundColor: mainYellowColor,
                      text: "تحميل تقرير الموظفين",
                      onPressed: () {
                        cubit.getReportEmployee(null, context);
                      },
                    ),
                    const SizedBox(width: 30),
                    myButton(
                      backgroundColor: mainYellowColor,
                      text: "رفع ملف البصامة",
                      onPressed: () {
                        cubit.pickTextFile(context);
                      },
                    ),
                    const SizedBox(width: 30),
                    myButton(
                      backgroundColor: mainYellowColor,
                      text: "إضافة موظف",
                      onPressed: () {
                        // navigateTo(context, AddEmployeeScreen());
                        var cubit = AppCubit.get(context);
                        if (AppLink.role == 'admin') {
                          cubit.screens[2] = AddEmployeeScreen();
                        } else {
                          cubit.screens[1] = AddEmployeeScreen();
                        }
                        cubit.emit(ScreenNavigationState());
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTable<Employee>(
                  list: cubit.employeesList,
                  type: "Employees",
                  pageIndex: cubit.employeesTablePageIndex,
                  changeTablePage: (int newPage) =>
                      cubit.changeEmpTablePage(newPage),
                  numColumns: 6,
                  labels: const [
                    'الاسم',
                    'الوظيفة',
                    'رقم الهاتف',
                    'تعديل',
                    'حذف',
                    'التفاصيل',
                  ],
                  flexes: const [3, 2, 3, 1, 1, 1],
                  sizedBoxesWidth: const [20, 20, 20, 10, 10],
                  tableFunctions: [
                    (Employee employee) =>
                        cubit.selectEmployeeToEdit(employee: employee),
                    (Employee employee) => showDialog(
                          context: context,
                          builder: (context) {
                            return BlocConsumer<EmployeesCubit,
                                    EmployeesStates>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return DeleteDialog(
                                      object: employee,
                                      deleteFunction: () {
                                        cubit.deleteEmployee(
                                            employeeId: employee.id!);
                                        Navigator.pop(context);
                                      });
                                });
                          },
                        ),
                    (Employee employee) {
                      cubit.selectEmployeeToShowDetails(employee: employee);
                      var appCubit = AppCubit.get(context);
                      int indx = AppLink.role == 'admin' ? 2 : 1;
                      appCubit.screens[indx] = ProfileScreen(
                        image: employee.image?.image,
                        rate: 4.0,
                        numOfServeces: 3, //employee.services!.length,
                        dataLabel: const [
                          [
                            'الاسم ',
                            'رقم الهاتف ',
                            'الوظيفة ',
                          ],
                          [
                            'الراتب ',
                            'تاريخ البدء',
                            'رقم البصامة ',
                          ]
                        ],
                        dataValue: [
                          [
                            "${employee.firstName}  ${employee.lastName}",
                            "${employee.phoneNumber}",
                            "${employee.position}",
                          ],
                          [
                            "${employee.salary ?? 'غير معروف'}",
                            "${employee.startDate?.year ?? 'غير معروف'}-${employee.startDate?.month ?? 'غير معروف'}-${employee.startDate?.day ?? 'غير معروف'}",
                            (employee.pin ?? 'غير معروف'),
                          ]
                        ],
                        sectionsVal: const [0, 100],
                        sectionsName: const ['حضور', "غياب"],
                        colors: const [mainYellowColor, mainBlueColor],
                      );
                      appCubit.emit(ScreenNavigationState());

                      // navigateTo(
                      //     context,
                      //     DashboardPageBuilder(
                      //       screenWidth: screenWidth,
                      //       screenHeight: screenHeight,
                      //       sideBarWidth: sideBarWidth,
                      //       pageContent: ProfileScreen(
                      //         rate: 4.0,
                      //         numOfServeces: 3, //employee.services!.length,
                      //         dataLabel: const [
                      //           'الاسم: ',
                      //           'رقم الهاتف: ',
                      //           'الوظيفة: ',
                      //         ],
                      //         dataValue: [
                      //           "${employee.firstName} ${employee.middleName} ${employee.lastName}",
                      //           "${employee.phoneNumber}",
                      //           "${employee.position}",
                      //           /*"${employee.salary}",
                      //     "${employee.startDate?.year}-${employee.startDate?.month}-${employee.startDate?.day}",*/
                      //         ],
                      //         sectionsVal: const [20, 80],
                      //         sectionsName: const ['حضور', "غياب"],
                      //         colors: const [mainYellowColor, mainBlueColor],
                      //       ),
                      //       isLogin: false,
                      //     ));
                    },
                    /*ProfileScreen(Y
                        rate: 4.0,
                        numOfServeces: 3,//employee.services!.length,
                        dataLabel: const ['الاسم: ', 'رقم الهاتف: ', 'الوظيفة: ',*/ /* 'الراتب: ', 'تاريخ التعيين: ',*/ /* ],
                        dataValue: [
                          "${employee.firstName} ${employee.middleName} ${employee.lastName}",
                          "${employee.phoneNumber}",
                          "${employee.position}",
                          */ /*"${employee.salary}",
                              "${employee.startDate?.year}-${employee.startDate?.month}-${employee.startDate?.day}",*/ /*
                        ],
                        sectionsVal: const [20, 80],
                        sectionsName: const ['حضور', "غياب"],
                        colors: const [mainYellowColor, mainBlueColor],
                      )),*/
                    /*DashboardPageBuilder(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          sideBarWidth: sideBarWidth,
                          pageContent: ProfileScreen(
                            rate: 4.0,
                            numOfServices: 3,//employee.services!.length,
                            dataLabel: const ['الاسم: ', 'رقم الهاتف: ', 'الوظيفة: ',*/ /* 'الراتب: ', 'تاريخ التعيين: ',*/ /* ],
                            dataValue: [
                              "${employee.firstName} ${employee.middleName} ${employee.lastName}",
                              "${employee.phoneNumber}",
                              "${employee.position}",
                              */ /*"${employee.salary}",
                              "${employee.startDate?.year}-${employee.startDate?.month}-${employee.startDate?.day}",*/ /*
                            ],
                            sectionsVal: const [20, 80],
                            sectionsName: const ['حضور', "غياب"],
                            colors: const [mainYellowColor, mainBlueColor],
                          ),
                          isLogin: false,
                        )),*/
                  ],
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
