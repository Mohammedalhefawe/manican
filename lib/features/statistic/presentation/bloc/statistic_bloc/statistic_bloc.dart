import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/core/function/error_message.dart';
import 'package:manicann/core/function/time_formatter.dart';
import 'package:manicann/features/statistic/data/models/attendance_daily_model.dart';
import 'package:manicann/features/statistic/data/models/attendance_monthly_model.dart';
import 'package:manicann/features/statistic/data/models/attendance_weekly_model.dart';
import 'package:manicann/features/statistic/data/models/statistic_model.dart';
import 'package:manicann/features/statistic/domain/entities/day_data.dart';
import 'package:manicann/features/statistic/domain/entities/statistic_card.dart';
import 'package:manicann/features/statistic/domain/usecases/statistics_usecase.dart';
import 'package:manicann/features/statistic/presentation/bloc/statistic_bloc/statistic_state.dart';

class StatisticBloc extends Cubit<StatisticState> {
  StatisticState statisticState = SuccessStatisticState();
  String isSelected = "شهري";
  bool isViewAll = false;
  List<DayData> dataAttendanceMonthlyChart = [],
      dataAttendanceYearlyChart = [],
      dataAttendanceChart = [];
  List<AttendanceDailyModel> dataAttendanceInfo = [];
  List<StatisticCardModel> dataStatistic = [];
  late StatisticsUsecase statisticsUsecase;
  TextEditingController dateController = TextEditingController(
      text:
          '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');

  StatisticBloc(super.initialState, {required this.statisticsUsecase}) {
    print('API:getAllStatistics:====>fetch');
    isBuiled = true;
    // getAllData();
    getAllData();
    print('API:getAllStatistics:====>done');
  }
  bool isBuiled = false;
  changeValDropDown(val) async {
    if (val != isSelected) {
      isSelected = val;
      if (val == "شهري") {
        await getAllAttendaceForMonth();
        dataAttendanceChart = dataAttendanceMonthlyChart;
      } else if (val == "سنوي") {
        await getAllAttendaceForYear().then((value) {
          dataAttendanceChart = dataAttendanceYearlyChart;
        });
      }
      emit(ChangeElementInDropDownState());
    }
  }

  changeDate(String? date) async {
    if (date != null && date != dateController.text) {
      dateController = TextEditingController(text: date);

      if (isSelected == "شهري") {
        await getAllAttendaceForMonth();
        dataAttendanceChart = dataAttendanceMonthlyChart;
      } else if (isSelected == "سنوي") {
        await getAllAttendaceForYear().then((value) {
          dataAttendanceChart = dataAttendanceYearlyChart;
        });
      }
      emit(ChangeElementInDropDownState());
    }
  }

  viewAll() {
    isViewAll = !isViewAll;
    emit(ViewAllState());
  }

  void getAllData() async {
    emit(LoadingStatisticState());
    try {
      await getAllStatistics();
      print('getAllStatistics----Done');
      await getAllAttendaceForMonth();
      print('getAllAttendaceForMonth----Done');
      await getAllAttendaceForDay();
      print('getAllAttendaceForDay----Done');

      // await getAllAttendaceForYear();
      // print('----4');

      emit(statisticState);
    } catch (e) {
      emit(ErrorStatisticState(message: 'حدث خطأ ما إثناء جلب المعلومات'));
    }
  }

  Future<void> getAllStatistics() async {
    emit(LoadingStatisticState());
    final mapData = await statisticsUsecase.getAllStatistics();
    // emit(mapFailureOrStatisticsToState(mapData));
    if (mapFailureOrStatisticsToState(mapData) != SuccessStatisticState()) {
      statisticState = mapFailureOrStatisticsToState(mapData);
    }
    // mapData.fold((Failure l) => l, (r) => r);
  }

  Future<void> getAllAttendaceForYear() async {
    emit(LoadingStatisticState());
    final mapData =
        await statisticsUsecase.getAllAttendanceForYear(dateController.text);
    emit(mapFailureOrAttendanceYearlyToState(mapData));
  }

  Future<void> getAllAttendaceForMonth() async {
    emit(LoadingStatisticState());
    final mapData =
        await statisticsUsecase.getAllAttendanceForMonth(dateController.text);
    // emit(mapFailureOrAttendanceMonthlyToState(mapData));
    StatisticState s = mapFailureOrAttendanceMonthlyToState(mapData);
    if (s != SuccessStatisticState()) {
      statisticState = s;
    }
  }

  Future<void> getAllAttendaceForDay() async {
    emit(LoadingStatisticState());
    final mapData = await statisticsUsecase.getAllDailyAttendance();
    // emit(mapFailureOrAttendanceDailyToState(mapData));
    StatisticState s = mapFailureOrAttendanceDailyToState(mapData);
    if (s != SuccessStatisticState()) {
      statisticState = s;
    }
  }

  StatisticState mapFailureOrStatisticsToState(
      Either<Failure, StatisticModel> either) {
    return either.fold(
      (l) => ErrorStatisticState(message: mapFailureToMessage(l)),
      (r) {
        StatisticModel data = r;
        print('Statistics Done ....');
        dataStatistic.add(
          StatisticCardModel(
              icon: Icons.assessment_outlined,
              title: 'إجمالي الخدمات',
              percent: '${Random().nextInt(90) + 2}',
              updateText: formatDate('2024-02-03'),
              number: data.totalServices.toString(),
              isIncrement: Random().nextBool()),
        );
        dataStatistic.add(
          StatisticCardModel(
              icon: Icons.people_alt_outlined,
              title: 'إجمالي الموظفين',
              percent: '${Random().nextInt(70) + 5}',
              updateText: formatDate('2024-04-04'),
              number: data.totalEmployees.toString(),
              isIncrement: Random().nextBool()),
        );
        dataStatistic.add(
          StatisticCardModel(
              icon: Icons.auto_fix_high_outlined,
              title: 'إجمالي الأطباء',
              percent: '${Random().nextInt(50) + 7}',
              updateText: formatDate('2024-06-12'),
              number: data.totalDoctors.toString(),
              isIncrement: Random().nextBool()),
        );
        dataStatistic.add(
          StatisticCardModel(
              icon: Icons.bar_chart_outlined,
              title: 'إجمالي الزبائن',
              percent: '${Random().nextInt(40) + 24}',
              updateText: formatDate('2024-02-04'),
              number: data.totalCustomers.toString(),
              isIncrement: Random().nextBool()),
        );
        return SuccessStatisticState();
      },
    );
  }

  StatisticState mapFailureOrAttendanceYearlyToState(
      Either<Failure, AttendanceYearlyModel> either) {
    return either.fold(
      (l) => ErrorStatisticState(message: mapFailureToMessage(l)),
      (r) {
        AttendanceYearlyModel data = r;
        List<MonthAttendance> months = [
          data.april,
          data.august,
          data.december,
          data.february,
          data.january,
          data.july,
          data.june,
          data.march,
          data.may,
          data.november,
          data.october,
          data.september,
        ];
        List<String> monthsInArabic = [
          'يناير',
          'فبراير',
          'مارس',
          'أبريل',
          'مايو',
          'يونيو',
          'يوليو',
          'أغسطس',
          'سبتمبر',
          'أكتوبر',
          'نوفمبر',
          'ديسمبر',
        ];
        dataAttendanceYearlyChart = [];
        for (var i = 0; i < months.length; i++) {
          dataAttendanceYearlyChart.add(DayData(
              monthsInArabic[i],
              months[i].attendances.toDouble(),
              months[i].lates.toDouble(),
              months[i].absences.toDouble()));
        }
        dataAttendanceChart = dataAttendanceMonthlyChart;
        return SuccessStatisticState();
      },
    );
  }

  StatisticState mapFailureOrAttendanceMonthlyToState(
      Either<Failure, AttendanceMonthlyModel> either) {
    return either.fold(
      (l) => ErrorStatisticState(message: mapFailureToMessage(l)),
      (r) {
        AttendanceMonthlyModel data = r;
        print('AttendanceMonthlyModel Done ....');
        List<AttendanceWeeklyData> weeks = [
          data.week1,
          data.week2,
          data.week3,
          data.week4
        ];
        List weekName = [
          'الأسبوع الأول',
          'الأسبوع الثاني',
          'الأسبوع الثالث',
          'الأسبوع الرابع'
        ];
        dataAttendanceMonthlyChart = [];
        for (var i = 0; i < weeks.length; i++) {
          dataAttendanceMonthlyChart.add(DayData(
              weekName[i],
              weeks[i].attendanceCount.toDouble(),
              weeks[i].latesCount.toDouble(),
              weeks[i].absencesCount.toDouble()));
        }
        dataAttendanceChart = dataAttendanceMonthlyChart;
        return SuccessStatisticState();
      },
    );
  }

  StatisticState mapFailureOrAttendanceDailyToState(
      Either<Failure, List<AttendanceDailyModel>> either) {
    return either.fold(
      (l) => ErrorStatisticState(message: mapFailureToMessage(l)),
      (r) {
        List<AttendanceDailyModel> data = r;
        print('AttendanceDaily Done ....');
        dataAttendanceInfo = data;
        return SuccessStatisticState();
      },
    );
  }
}
