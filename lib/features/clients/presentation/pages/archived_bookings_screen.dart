import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/features/clients/domain/entities/booking.dart';
import 'package:manicann/features/clients/presentation/bloc/cubit.dart';
import 'package:manicann/features/clients/presentation/bloc/states.dart';
import 'package:manicann/features/clients/presentation/pages/clients_screen.dart';
import 'package:manicann/features/clients/presentation/widgets/dialog_process_booking.dart';
import '../../../../core/components/custom_table.dart';
import '../../../../core/components/dashboard_builder.dart';
import '../../../../core/components/page_label.dart';
import '../../../../core/theme/app_colors.dart';

class ArchivedBookingScreen extends StatelessWidget {
  const ArchivedBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = max(MediaQuery.of(context).size.width, 1000);
    double screenHeight = max(MediaQuery.of(context).size.height, 650);
    double sideBarWidth = 210;
    return BlocConsumer<ClientsCubit, ClientsStates>(
      listener: (context, state) {
        if (state is GetClientArchivedBookingsErrorState) {
          CustomToast t = CustomToast(type: "Error", msg: state.error);
          t(context);
        }
      },
      builder: (context, state) {
        var cubit = ClientsCubit.get(context);

        Widget pageContent = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60),
          child: ConditionalBuilder(
            condition: state is! GetClientArchivedBookingsLoadingState,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      var appCubit = AppCubit.get(context);
                      appCubit.updateSelected(4);
                      // appCubit.screens[4] = const ClientsScreen();
                      // appCubit.emit(ScreenNavigationState());
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
                    pageLabelBuilder(label: "سجل حجوزات العميل: "),
                    Expanded(
                        child: pageLabelBuilder(
                            label:
                                "${cubit.detailsClient?.firstName} ${cubit.detailsClient?.middleName} ${cubit.detailsClient?.lastName}")),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    myButton(
                        backgroundColor: mainYellowColor,
                        text: "عرض الأرشيف",
                        onPressed: () {})
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTable<Booking>(
                  list: cubit.clientArchivedBookings,
                  type: "ArchivedBookings",
                  pageIndex: cubit.archivedBookingsPageIndex,
                  changeTablePage: (int newPage) =>
                      cubit.changeArchivedBookingsPage(newPage),
                  numColumns: 7,
                  labels: const [
                    'اسم الموظف',
                    'الخدمة',
                    'الحالة',
                    'اليوم',
                    '    التاريخ',
                    '  وقت البدء',
                    'وقت الانتهاء',
                  ],
                  flexes: const [3, 3, 3, 2, 2, 1, 2],
                  sizedBoxesWidth: const [25, 25, 25, 25, 15, 15],
                  tableFunctions: [
                    (Booking booking) {
                      if (booking.id != null) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ProcessBookingDialog(
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
