import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/bookings/presentation/pages/current_bookings_screen.dart';
import '../../../../core/components/custom_table.dart';
import '../../../../core/components/dashboard_builder.dart';
import '../../../../core/components/drop_down_button.dart';
import '../../../../core/components/page_label.dart';
import '../../../../core/components/search_text_form_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../clients/domain/entities/booking.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';

class BranchArchivedBookingScreen extends StatelessWidget {
  const BranchArchivedBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = max(MediaQuery.of(context).size.width, 1000);
    double screenHeight = max(MediaQuery.of(context).size.height, 650);
    double sideBarWidth = 210;
    return BlocConsumer<BookingsCubit, BookingsStates>(
      listener: (context, state) {
        if (state is GetArchivedBookingsErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
      },
      builder: (context, state) {
        var cubit = BookingsCubit.get(context);

        Widget pageContent = Padding(
          padding: const EdgeInsets.only(
            left: 40.0,
            right: 40.0,
            bottom: 60,
            top: 20.0,
          ),
          child: ConditionalBuilder(
            condition: state is! GetArchivedBookingsLoadingState,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      var appCubit = AppCubit.get(context);
                      if (AppLink.role == 'admin') {
                        appCubit.screens[3] =
                            const BranchCurrentBookingsScreen();
                      } else {
                        appCubit.screens[2] =
                            const BranchCurrentBookingsScreen();
                      }
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
                    pageLabelBuilder(label: "أرشيف الحجوزات"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    searchFieldBuilder(
                      hintText: "ابحث هنا...",
                      onChanged: (String value) {
                        cubit.searchInArchivedList(value);
                      },
                      contentPadding: 14,
                    ),
                    const Spacer(),
                    myDropDownMenuButton(
                      borderColor: mainYellowColor,
                      testList: cubit.archivedBookingListFilterTypes,
                      onChanged: (Text? text) {
                        cubit.changeArchivedBookingsTableFilter(text);
                      },
                      value: cubit.archivedBookingsTableFilterType,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTable<Booking>(
                  list: cubit.archivedBookingsList,
                  type: "AllArchivedBookings",
                  pageIndex: cubit.archivedBookingsTablePageIndex,
                  changeTablePage: (int newPage) =>
                      cubit.changeArchivedBookingTablePage(newPage),
                  numColumns: 8,
                  labels: const [
                    'اسم الزبون',
                    'اسم الموظف',
                    'الخدمة',
                    'الحالة',
                    'اليوم',
                    '    التاريخ',
                    '  وقت البدء',
                    'وقت الانتهاء',
                  ],
                  flexes: const [5, 5, 3, 2, 2, 4, 4, 4],
                  sizedBoxesWidth: const [25, 25, 25, 25, 25, 15, 15],
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
