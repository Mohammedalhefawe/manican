import 'package:flutter/material.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/features/statistic/domain/entities/statistic_card.dart';
import 'package:sizer/sizer.dart';

class StatisticsCard extends StatefulWidget {
  final StatisticCardModel statisticCard;

  const StatisticsCard({
    super.key,
    required this.statisticCard,
  });

  @override
  _StatisticsCardState createState() => _StatisticsCardState();
}

class _StatisticsCardState extends State<StatisticsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = CurvedAnimation(
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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 20.w,
        padding: EdgeInsets.symmetric(horizontal: 1.1.w, vertical: 1.3.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildHeaderRow(
              icon: widget.statisticCard.icon,
              text: widget.statisticCard.title,
            ),
            SizedBox(height: 1.1.h),
            buildStatRow(
              number: widget.statisticCard.number,
              percent: widget.statisticCard.percent,
              isIncrement: widget.statisticCard.isIncrement,
            ),
            SizedBox(height: 1.1.h),
            buildUpdateText(updateText: widget.statisticCard.updateText),
          ],
        ),
      ),
    );
  }
}

Widget buildHeaderRow({required String text, required IconData icon}) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(113, 82, 243, 0.05),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      const SizedBox(width: 12),
      Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ],
  );
}

Widget buildStatRow(
    {required String number,
    required bool isIncrement,
    required String percent}) {
  return Row(
    children: [
      Text(
        number,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
      ),
      const Spacer(),
      buildPercentageIndicator(isIncrement, "$percent%"),
    ],
  );
}

Widget buildPercentageIndicator(bool isDecrement, String percentage) {
  final color = isDecrement
      ? const Color.fromRGBO(244, 91, 105, 1)
      : const Color.fromRGBO(63, 194, 138, 1);
  final icon =
      isDecrement ? Icons.arrow_drop_down_rounded : Icons.arrow_drop_up_rounded;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 4),
        Text(
          percentage,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

Widget buildUpdateText({required String updateText}) {
  return Text(
    "أخر تحديث : $updateText ",
    style: const TextStyle(color: Colors.grey, fontSize: 12),
  );
}
