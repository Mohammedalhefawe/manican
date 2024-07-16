import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manican/features/statistic/domain/entities/attedance.dart';
import 'package:manican/features/statistic/domain/entities/day_data.dart';
import 'package:manican/features/statistic/presentation/bloc/attendance_bloc/attendance_state.dart';

class AttendanceBloc extends Cubit<AttendanceState> {
  var isSelected;
  bool isViewAll = false;
  List<DayData> dataAttendanceChart = [];
  List<Attendance> dataAttendanceInfo = [];
  AttendanceBloc() : super(AttendanceInitial()) {
    dataAttendanceChart = [
      DayData("x", 20, 40, 40),
      DayData("y", 30, 40, 30),
      DayData("z", 50, 30, 20),
      DayData("x", 20, 40, 40),
      DayData("y", 30, 40, 30),
      DayData("z", 50, 30, 20)
    ];
    dataAttendanceInfo = List.generate(
        25,
        (index) => Attendance(
              name: "Mohammad" + Random().nextInt(1000).toString(),
              designation: "Flutter Dev",
              checkInTime: "Pm 12:44",
              imageUrl:
                  "https://www.allprodad.com/wp-content/uploads/2021/03/05-12-21-happy-people.jpg",
              status: Random().nextBool(),
            ));
  }
  changeValDropDown(val) {
    if (val != isSelected) {
      isSelected = val;
      if (val == "Today") {
        dataAttendanceChart = [
          DayData("x", 20, 40, 40),
          DayData("y", 30, 40, 30),
          DayData("z", 50, 30, 20)
        ];
      } else if (val == "Month") {
        dataAttendanceChart = [
          DayData("x", 20, 40, 40),
          DayData("y", 30, 40, 30),
          DayData("z", 50, 30, 20),
          DayData("x", 20, 40, 40),
          DayData("y", 30, 40, 30),
          DayData("z", 50, 30, 20)
        ];
      } else if (val == "Year") {
        dataAttendanceChart = [
          DayData("2014", 20, 40, 40),
          DayData("2015", 30, 40, 30),
          DayData("2016", 50, 30, 20),
          DayData("2017", 20, 40, 40),
        ];
      }
      emit(ChangeElementInDropDownState());
    }
  }

  viewAll() {
    isViewAll = !isViewAll;
    emit(ViewAllState());
  }
}
