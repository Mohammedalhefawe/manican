import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manican/core/components/custom_textfiled.dart';
import 'package:manican/core/constance/constance.dart';
import 'package:manican/core/theme/app_colors.dart';
import 'package:manican/features/statistic/domain/entities/statistic_card.dart';
import 'package:manican/features/statistic/presentation/bloc/attendance_bloc/attendance_bloc.dart';
import 'package:manican/core/generated/codegen_loader.g.dart';
import 'package:manican/features/offers/presentation/bloc/carousel_slider_bloc/carousel_slider_bloc.dart';
import 'package:manican/core/theme/app_theme.dart';
import 'package:manican/di/appInitializer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:manican/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:manican/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:manican/di/injectionContainer.dart' as di;
import 'package:manican/features/statistic/presentation/bloc/attendance_bloc/attendance_state.dart';
import 'package:manican/features/statistic/presentation/widgets/attendance_overview_chart_widget.dart';
import 'package:manican/features/statistic/presentation/widgets/attendance_overview_widget.dart';
import 'package:manican/features/statistic/presentation/widgets/satistics_card_widget.dart';
import 'package:sizer/sizer.dart';

void main() async {
  AppInitializer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
        supportedLocales: [arabicLocale, englishLocale],
        path: 'assets/i18n',
        fallbackLocale: englishLocale,
        startLocale: englishLocale,
        saveLocale: false,
        useOnlyLangCode: true,
        assetLoader: const CodegenLoader(),
        child: Builder(builder: (context) {
          return Sizer(builder: (context, orientation, deviceType) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) =>
                        di.sl<PostsBloc>()..add(GetAllPostsEvent())),
                BlocProvider(
                    create: (context) => di.sl<AddDeleteUpdatePostBloc>()),
                BlocProvider(create: (context) => CarouselSliderBloc()),
                BlocProvider(create: (context) => AttendanceBloc()),
              ],
              child: MaterialApp(
                title: 'title',
                theme: appTheme,
                locale: context.locale,
                builder: (context, child) => Overlay(
                  initialEntries: [
                    OverlayEntry(
                      builder: (context) => Navigator(
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                      ),
                    ),
                  ],
                ),
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                debugShowCheckedModeBanner: false,
              ),
            );
          });
        }));
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Container(
          height: 100.h,
          width: 20.w,
          color: Colors.grey,
        ),
        SingleChildScrollView(
          child: Container(
            width: 80.w,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Offers",
                    // style: GoogleFonts.glegoo(
                    //   fontSize: 32,
                    //   fontWeight: FontWeight.w700,
                    // ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                       
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}



// class StatisticsScreen extends StatelessWidget {
//   const StatisticsScreen({
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         width: 80.w,
//         color: Colors.white,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Offers",
//                 // style: GoogleFonts.glegoo(
//                 //   fontSize: 32,
//                 //   fontWeight: FontWeight.w700,
//                 // ),
//               ),
//               SizedBox(
//                 height: 4.h,
//               ),
//               SizedBox(
//                 height: 45.h,
//                 child: SizedBox(
//                   height: 20.h,
//                   child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 1.6.w,
//                       mainAxisSpacing: 2.5.h,
//                       childAspectRatio: 2.5 / 1.3,
//                     ),
//                     itemBuilder: (context, index) {
//                       return StatisticsCard(
//                           statisticCard: StatisticCard(
//                               icon: Icons.home,
//                               title: 'title',
//                               number: '${Random().nextInt(1000)}',
//                               updateText: 'updateText',
//                               percent: '${Random().nextInt(100)}',
//                               isIncrement: Random().nextBool()));
//                     },
//                     itemCount: 6,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 4.h,
//               ),
//               SizedBox(
//                 height: 55.h,
//                 width: 80.w,
//                 child: BlocBuilder<AttendanceBloc, AttendanceState>(
//                     builder: (context, state) {
//                   var bloc = BlocProvider.of<AttendanceBloc>(context);
//                   return AttendanceOverviewChart(
//                       data: bloc.dataAttendanceChart);
//                 }),
//               ),
//               SizedBox(
//                 height: 4.h,
//               ),
//               const AttendanceOverview()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

/*

*/
