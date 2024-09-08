import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/features/branches/presentation/bloc/branches_bloc/branches_bloc.dart';
import 'package:sizer/sizer.dart';

class WorkDaysSelection extends StatefulWidget {
  const WorkDaysSelection({super.key});

  @override
  _WorkDaysSelectionState createState() => _WorkDaysSelectionState();
}

class _WorkDaysSelectionState extends State<WorkDaysSelection> {
  List<String> days = [
    "الأحد",
    "الإثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
  ];

  List<bool> selected = List.generate(6, (_) => false);

  @override
  Widget build(BuildContext context) {
    BranchesBloc bloc = BlocProvider.of<BranchesBloc>(context);

    return SizedBox(
      width: 25.w,
      height: 20.h,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.0,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selected[index] = !selected[index];
              });
              if (selected[index] == true) {
                bloc.selectedWorkDays.add(days[index]);
              } else {
                bloc.selectedWorkDays.remove(days[index]);
              }
              print(bloc.selectedWorkDays);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10, bottom: 12),
              width: 2.w,
              height: 2.h,
              decoration: BoxDecoration(
                color: selected[index]
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  days[index],
                  style: const TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
