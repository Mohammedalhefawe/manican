import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/error_widget.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/shared_screen/no_data_screen.dart';
import 'package:manicann/features/statistic/presentation/bloc/statistic_bloc/statistic_bloc.dart';
import 'package:manicann/features/statistic/presentation/bloc/statistic_bloc/statistic_state.dart';
import 'package:manicann/features/statistic/presentation/widgets/attendance_overview_chart_widget.dart';
import 'package:manicann/features/statistic/presentation/widgets/attendance_overview_widget.dart';
import 'package:manicann/features/statistic/presentation/widgets/satistics_card_widget.dart';
import 'package:manicann/shared_screen/main_layout_screen.dart';
import 'package:sizer/sizer.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticBloc, StatisticState>(
      builder: (context, state) {
        StatisticBloc bloc = BlocProvider.of<StatisticBloc>(context);
        Widget pageContent;

        if (state is ErrorStatisticState) {
          pageContent = MyErrorWidget(
            text: state.message,
            onTap: () {
              bloc.getAllData();
            },
          );
        } else if (state is LoadingStatisticState) {
          pageContent = const LoadingWidget();
        } else {
          bool isEmptyScreen = bloc.dataAttendanceInfo.isEmpty &&
              bloc.dataAttendanceChart.isEmpty &&
              bloc.dataStatistic.isEmpty;
          pageContent = isEmptyScreen
              ? const EmptyScreen()
              : SingleChildScrollView(
                  child: Container(
                    // width: 80.w,
                    color: Colors.transparent,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "الاحصائيات",
                            // "Statistics",

                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          bloc.dataStatistic.isEmpty
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    SizedBox(
                                      height: 45.h,
                                      child: SizedBox(
                                        // height: 20.h,
                                        child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 1.6.w,
                                            mainAxisSpacing: 2.5.h,
                                            childAspectRatio: 2.5 / 1,
                                          ),
                                          // physics: const NeverScrollableScrollPhysics(),
                                          // shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return StatisticsCard(
                                                statisticCard:
                                                    bloc.dataStatistic[index]);
                                          },
                                          itemCount: 4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          bloc.dataAttendanceChart.isEmpty
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    SizedBox(
                                      height: 55.h,
                                      width: 80.w,
                                      child: AttendanceOverviewChart(
                                          data: bloc.dataAttendanceChart),
                                    ),
                                  ],
                                ),
                          bloc.dataAttendanceInfo.isEmpty
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    AttendanceOverview(
                                      bloc: bloc,
                                    )
                                  ],
                                )
                        ],
                      ),
                    ),
                  ),
                );
        }
        return MainLayoutScreen(
          pageContent: pageContent,
        );
      },
    );
  }
}
