import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/components/drop_down_button.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/features/complaints/domain/entities/complaint.dart';
import 'package:manicann/features/complaints/presentation/bloc/cubit.dart';
import 'package:manicann/features/complaints/presentation/bloc/states.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/components/custom_table.dart';
import '../../../../core/components/dashboard_builder.dart';
import '../../../../core/components/page_label.dart';
import '../../../../core/components/search_text_form_field.dart';
import '../../../../core/theme/app_colors.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = max(MediaQuery.of(context).size.width, 1000);
    double screenHeight = max(MediaQuery.of(context).size.height, 650);
    double sideBarWidth = 210;
    return BlocConsumer<ComplaintsCubit, ComplaintsStates>(
      listener: (context, state) {
        if (state is GetComplaintsErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
        if (state is HideComplaintSuccessState) {
          CustomToast t =
              const CustomToast(type: "Success", msg: "تم حذف الشكوى بنجاح");
          t(context);
        }
      },
      builder: (context, state) {
        var cubit = ComplaintsCubit.get(context);

        Widget pageContent = Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 4.h),
            child: ConditionalBuilder(
                condition: state is! GetComplaintsLoadingState,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pageLabelBuilder(label: "الشكاوي"),
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
                          const Spacer(),
                          myDropDownMenuButton(
                            borderColor: mainYellowColor,
                            testList: cubit.employeesFilterTypes,
                            onChanged: (Text? text) {
                              cubit.changeText(text);
                            },
                            value: cubit.complaintsTableFilter,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTable<Complaint>(
                        list: cubit.complaintsList,
                        type: "Complaints",
                        pageIndex: cubit.complaintsTablePageIndex,
                        changeTablePage: (int newPage) =>
                            cubit.changeEmpTablePage(newPage),
                        numColumns: 5,
                        labels: const [
                          'العميل',
                          'تاريخ الشكوى',
                          'اليوم',
                          'المحتوى',
                          'حذف',
                        ],
                        flexes: const [4, 2, 2, 4, 1],
                        sizedBoxesWidth: const [20, 20, 20, 10],
                        tableFunctions: [
                          (Complaint complaint) =>
                              cubit.hideComplaint(complaint.id!)
                        ],
                        width: screenWidth,
                        height: screenHeight,
                      ),
                    ],
                  );
                },
                fallback: (context) => const LoadingWidget()));

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
