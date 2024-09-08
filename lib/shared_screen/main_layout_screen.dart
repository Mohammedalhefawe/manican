import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:manicann/core/components/dashboard_builder.dart';

class MainLayoutScreen extends StatelessWidget {
  final Widget pageContent;
  final bool? isLogin;
  const MainLayoutScreen({super.key, required this.pageContent, this.isLogin});

  @override
  Widget build(BuildContext context) {
    double screenWidth = max(MediaQuery.of(context).size.width, 1000);
    double screenHeight = MediaQuery.of(context).size.height;
    double sideBarWidth = 210;
    return DashboardPageBuilder(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      sideBarWidth: sideBarWidth,
      pageContent: pageContent,
      isLogin: isLogin ?? false,
    );
  }
}
