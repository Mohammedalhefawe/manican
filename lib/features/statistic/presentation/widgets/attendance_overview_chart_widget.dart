// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/custom_drop_down.dart';
import 'package:manicann/core/components/custom_textFiled_datePicker.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/features/statistic/domain/entities/day_data.dart';
import 'package:manicann/features/statistic/presentation/bloc/statistic_bloc/statistic_bloc.dart';
import 'package:manicann/features/statistic/presentation/bloc/statistic_bloc/statistic_state.dart';
import 'package:sizer/sizer.dart';

class AttendanceOverviewChart extends StatefulWidget {
  final List<DayData> data;
  const AttendanceOverviewChart({super.key, required this.data});

  @override
  _AttendanceOverviewChartState createState() =>
      _AttendanceOverviewChartState();
}

class _AttendanceOverviewChartState extends State<AttendanceOverviewChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<DayData> data = [];

  @override
  void initState() {
    super.initState();
    data = widget.data;
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<StatisticBloc, StatisticState>(
          listener: (context, state) {
        if (state is ChangeElementInDropDownState) {
          _controller.reset();
          _controller.forward();
        }
      }, builder: (context, state) {
        var bloc = BlocProvider.of<StatisticBloc>(context);
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(bloc: bloc),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  children: [
                    buildPercentageAxis(),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: bloc.dataAttendanceChart.map((day) {
                          DayData data = DayData(
                              day.day,
                              (100 - day.late - day.present),
                              day.late,
                              day.absent);
                          return buildColumnWithLabels(data);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildHeader({required StatisticBloc bloc}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'احصائيات الدوام',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 11.w,
              child: CustomDatePicker(
                hintText: "حدد تاريخ الاحصائية",
                onChanged: (val) {
                  bloc.changeDate(val);
                },
              ),
            ),
            SizedBox(
              width: 1.w,
            ),
            SizedBox(
              width: 11.w,
              child: CustomDropDownButton(
                hintText: "شهري",
                listData: const ["شهري", "سنوي"],
                isSelected: bloc.isSelected,
                onChanged: (val) {
                  bloc.changeValDropDown(val!);
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildPercentageAxis() {
    return Column(
      children: List.generate(5, (index) {
        return Expanded(
          child: Text(
            '${100 - index * 25}%',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        );
      }),
    );
  }

  Widget buildColumnWithLabels(DayData day) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return buildCustomBar(day.present, day.late, day.absent);
          },
        ),
        const SizedBox(height: 8),
        Text(day.day, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget buildCustomBar(double present, double late, double absent) {
    const double width = 10;
    const double borderRadius = 4;
    const double margin = 2;
    return SizedBox(
      width: width,
      height: 200,
      child: CustomPaint(
        painter: RoundedStackBarPainter(
          colors: const [
            Color.fromARGB(255, 113, 82, 243),
            Colors.white,
            Color.fromARGB(255, 254, 184, 91),
            Colors.white,
            Color.fromARGB(255, 244, 91, 105)
          ],
          values: [present, margin, late, margin, absent],
          width: width,
          borderRadius: borderRadius,
          animationValue: _animation.value,
        ),
      ),
    );
  }
}

class RoundedStackBarPainter extends CustomPainter {
  final List<Color> colors;
  final List<double> values;
  final double width;
  final double borderRadius;
  final double animationValue;

  RoundedStackBarPainter({
    required this.colors,
    required this.values,
    required this.width,
    required this.borderRadius,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    double currentHeight = 0;

    for (int i = 0; i < values.length; i++) {
      if (values[i] > 0) {
        paint.color = colors[i];
        final barHeight = (values[i] / 100) * size.height * animationValue;
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
              0, size.height - currentHeight - barHeight, width, barHeight),
          Radius.circular(borderRadius),
        );
        canvas.drawRRect(rect, paint);
        currentHeight += barHeight;
      }
    }
  }

  @override
  bool shouldRepaint(covariant RoundedStackBarPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
