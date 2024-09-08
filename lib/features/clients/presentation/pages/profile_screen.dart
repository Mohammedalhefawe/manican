import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/buttons.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/clients/presentation/bloc/cubit.dart';
import 'package:manicann/features/clients/presentation/bloc/states.dart';
import 'package:manicann/features/clients/presentation/pages/clients_screen.dart';
import 'package:manicann/features/clients/presentation/pages/current_bookings_screen.dart';

import 'package:manicann/features/customer/presentation/widgets/top_profile.dart';
import 'package:manicann/features/employees/presentation/widgets/statistics.dart';
import 'package:manicann/shared_screen/main_layout_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constance/appImgaeAsset.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class ClientProfileScreen extends StatelessWidget {
  final String? image;
  final List dataLabel;
  final List dataValue;
  final List<double> sectionsVal;
  final List<String> sectionsName;
  final List<Color> colors;

  const ClientProfileScreen(
      {super.key,
      this.image,
      required this.dataLabel,
      required this.dataValue,
      required this.sectionsVal,
      required this.sectionsName,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientsCubit, ClientsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ClientsCubit.get(context);
          Widget pageContent;
          pageContent = Scaffold(
            backgroundColor: Colors.transparent,
            body: ConditionalBuilder(
              condition: state is! GetBookingPercentageLoadingState,
              builder: (context) => Row(
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
                                    ? Image.network(image!,
                                        fit: BoxFit.cover,
                                        height: 15.w,
                                        width: 15.w, errorBuilder:
                                            (context, error, stackTrace) {
                                        return Image.asset(
                                            AppImageAsset.defaultUserImage);
                                      })
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
                                text: "عرض الحجوزات", //"عرض سجل الحضور",
                                onPressed: () {
                                  if (cubit.detailsClient!.id != null) {
                                    cubit.getClientCurrentBookings(
                                        cubit.detailsClient!.id!);
                                    var appCubit = AppCubit.get(context);
                                    // appCubit.screens[4] =
                                    //     const CurrentBookingsScreen();
                                    if (AppLink.role == 'admin') {
                                      appCubit.screens[4] =
                                          const CurrentBookingsScreen();
                                    } else {
                                      appCubit.screens[3] =
                                          const CurrentBookingsScreen();
                                    }
                                    appCubit.emit(ScreenNavigationState());
                                  } else {
                                    CustomToast t = const CustomToast(
                                        type: "Error",
                                        msg: "حدث خطأ غير متوقع أعد المحاولة");
                                    t(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              fallback: (context) => const Center(
                child: LoadingWidget(),
              ),
            ),
          );

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
