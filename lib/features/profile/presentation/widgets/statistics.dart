import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class StatisticsWidget extends StatefulWidget {
  final List<double> sectionsVal;
  final List<String> sectionsName;
  final List<Color> colors;
  const StatisticsWidget(
      {super.key,
      required this.colors,
      required this.sectionsVal,
      required this.sectionsName});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<StatisticsWidget> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              sections: showingSections(
                sections: widget.sectionsVal,
                colors: widget.colors,
              ),
            ),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.sectionsVal.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundColor: widget.colors[index],
                        radius: 12,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        widget.sectionsName[index],
                        style: TextStyle(
                            fontSize: 4.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections(
      {required List<double> sections, required List<Color> colors}) {
    return List.generate(sections.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: colors[i],
        value: sections[i],
        title: '${sections[i]}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
          shadows: shadows,
        ),
      );
    });
  }
}


/*

 SizedBox(
            height: 3.h,
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(children: [
                      CircleAvatar(backgroundColor:widget.colors[index],radius: 10,),
                      SizedBox(
                      width: 2.w,
                    ),
                    Text('text...',style: TextStyle(fontSize: 18,color: Colors.black),),
                    ],);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 4.w,
                    );
                  },
                  itemCount: widget.sections.length),
            ),
          )
 */