import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/features/booking/presentation/pages/booking_screen.dart';
import 'package:manicann/features/bookings/presentation/bloc/cubit.dart';
import 'package:manicann/features/bookings/presentation/pages/archived_bookings_screen.dart';
import 'package:manicann/features/bookings/presentation/widgets/process_dialog.dart';
import '../../../../core/components/custom_table.dart';
import '../../../../core/components/dashboard_builder.dart';
import '../../../../core/components/drop_down_button.dart';
import '../../../../core/components/page_label.dart';
import '../../../../core/components/search_text_form_field.dart';
import '../../../../core/constance/appLink.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../clients/domain/entities/booking.dart';
import '../bloc/states.dart';

class BranchCurrentBookingsScreen extends StatelessWidget {
  const BranchCurrentBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = max(MediaQuery.of(context).size.width, 1000);
    double screenHeight = max(MediaQuery.of(context).size.height, 650);
    double sideBarWidth = 210;
    return BlocConsumer<BookingsCubit, BookingsStates>(
      listener: (context, state) {
        if (state is GetCurrentBookingsErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
        if (state is ReportBookingErrorState) {
          CustomToast t = const CustomToast(
              type: "Error",
              msg: 'حدث خطأ إثناء فتح التقرير , أعد المحاولة لاحقاً');
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
            condition: state is! GetCurrentBookingsLoadingState,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      var cubit = AppCubit.get(context);
                      if (AppLink.role == 'admin') {
                        cubit.screens[3] = const BranchCurrentBookingsScreen();
                      } else {
                        cubit.screens[2] = const BranchCurrentBookingsScreen();
                      }
                      cubit.emit(ScreenNavigationState());
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
                    pageLabelBuilder(label: "الحجوزات"),
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
                        cubit.searchCurrentInList(value);
                      },
                      contentPadding: 14,
                    ),
                    const SizedBox(width: 30),
                    myDropDownMenuButton(
                      borderColor: mainYellowColor,
                      testList: cubit.currentBookingListFilterTypes,
                      onChanged: (Text? text) {
                        cubit.changeCurrentBookingsTableFilter(text);
                      },
                      value: cubit.currentBookingsTableFilterType,
                    ),
                    const Spacer(),
                    myButton(
                      backgroundColor: mainYellowColor,
                      text: 'إضافة حجز',
                      onPressed: () {
                        var appCubit = AppCubit.get(context);

                        if (AppLink.role == 'admin') {
                          appCubit.screens[3] = const AddBookingScreen(
                            idCustomer: null,
                          );
                        } else {
                          appCubit.screens[2] = const AddBookingScreen(
                            idCustomer: null,
                          );
                        }
                        // cubit.screens[3] = const AddBookingScreen();
                        appCubit.emit(ScreenNavigationState());
                      },
                    ),
                    const SizedBox(width: 30),
                    myButton(
                      backgroundColor: mainYellowColor,
                      text: "تحميل تقرير الحجوزات",
                      onPressed: () {
                        cubit.getReportBooking(context);
                      },
                    ),
                    const SizedBox(width: 30),
                    myButton(
                        backgroundColor: mainYellowColor,
                        text: "عرض الأرشيف",
                        onPressed: () {
                          cubit.getAllArchivedBookings(
                              int.parse(AppLink.branchId));
                          var appCubit = AppCubit.get(context);
                          if (AppLink.role == 'admin') {
                            appCubit.screens[3] =
                                const BranchArchivedBookingScreen();
                          } else {
                            appCubit.screens[2] =
                                const BranchArchivedBookingScreen();
                          }
                          appCubit.emit(ScreenNavigationState());
                        })
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTable<Booking>(
                  list: cubit.currentBookingsList,
                  type: "AllCurrentBookings",
                  pageIndex: cubit.currentBookingsTablePageIndex,
                  changeTablePage: (int newPage) =>
                      cubit.changeCurrentBookingTablePage(newPage),
                  numColumns: 8,
                  labels: const [
                    'اسم الزبون',
                    'اسم الموظف',
                    'الخدمة',
                    'الحالة',
                    'اليوم',
                    '    التاريخ',
                    '  الوقت',
                    '',
                  ],
                  flexes: const [5, 5, 3, 3, 3, 4, 3, 3],
                  sizedBoxesWidth: const [25, 25, 25, 25, 15, 15, 15],
                  tableFunctions: [
                    (Booking booking) {
                      if (booking.id != null) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ProcessBranchBookingDialog(
                                  bookingId: booking.id!);
                            });
                      }
                    },
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
