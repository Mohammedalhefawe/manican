import 'package:flutter/material.dart';
import 'package:manicann/core/constance/constance.dart';
import 'package:manicann/core/generated/codegen_loader.g.dart';
import 'package:manicann/di/appInitializer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:manicann/features/bookings/presentation/bloc/cubit.dart';
import 'package:manicann/shared_screen/error_screen.dart';
import 'package:manicann/features/clients/presentation/bloc/cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/theme/app_theme.dart';
import 'package:manicann/features/authentication/presentation/bloc/cubit.dart';
import 'package:manicann/features/before_after/presentation/bloc/cubit/before_after_cubit.dart';
import 'package:manicann/features/booking/presentation/bloc/cubit/booking_bolc_cubit.dart';
import 'package:manicann/features/branches/presentation/bloc/branches_bloc/branches_bloc.dart';
import 'package:manicann/features/complaints/presentation/bloc/cubit.dart';
import 'package:manicann/features/employees/presentation/bloc/cubit.dart';
import 'package:manicann/features/offers/presentation/bloc/offer_bloc/offer_bloc.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_cubit.dart';
import 'package:manicann/features/statistic/presentation/bloc/statistic_bloc/statistic_bloc.dart';
import 'package:manicann/shared_screen/wait_update_screen.dart';
import 'package:manicann/di/injectionContainer.dart' as di;

void main() async {
  ///because binding should be initialized before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  AppInitializer.init();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    print(details.exceptionAsString());
    return MaterialApp(
      home: ErrorScreen(errorMessage: details.exceptionAsString()),
    );
  };

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
      startLocale: arabicLocale,
      saveLocale: false,
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: Builder(builder: (context) {
        return Sizer(builder: (context, orientation, deviceType) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => di.sl<LoginCubit>()),
              BlocProvider(create: (context) => di.sl<StatisticBloc>()),
              BlocProvider(create: (context) => di.sl<BranchesBloc>()),
              BlocProvider(create: (context) => di.sl<BookingBloc>()),
              BlocProvider(create: (context) => di.sl<BeforeAfterBloc>()),
              BlocProvider(create: (context) => di.sl<OffersBloc>()),
              BlocProvider(create: (context) => di.sl<ServiceBloc>()),
              BlocProvider(
                  create: (context) => di.sl<BookingsCubit>()
                    ..getAllCurrentBookings(int.parse(AppLink.branchId))),
              BlocProvider(
                  create: (context) => di.sl<ClientsCubit>()
                    ..getAllClients(int.parse(AppLink.branchId))),
              BlocProvider(create: (context) => AppCubit()),
              BlocProvider(
                  create: (context) => di.sl<EmployeesCubit>()
                    ..getAllEmployees(int.parse(AppLink.branchId))),
              BlocProvider(
                  create: (context) => di.sl<ComplaintsCubit>()
                    ..getAllComplaints(int.parse(AppLink.branchId))),
            ],
            child: BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                print('rebuild...............................');
                AppCubit cubit = AppCubit.get(context);
                return MaterialApp(
                  title: 'AlMALIKAN',
                  theme: appTheme,
                  locale: context.locale,
                  builder: (context, child) => Overlay(
                    initialEntries: [
                      OverlayEntry(
                        builder: (context) => Navigator(
                          onGenerateRoute: (settings) => MaterialPageRoute(
                            builder: (context) => LayoutBuilder(
                              builder: (context, constraints) {
                                double screenWidth = constraints.maxWidth;
                                double screenheight = constraints.maxHeight;
                                if (screenWidth >= 1300 &&
                                    screenheight > 630) {
                                  if (AppInitializer.isHaveAuth) {
                                    if (AppLink.branchId == '0') {
                                      print('............1');
                                      return cubit.screens[1];

                                    }
                                    print('............2');
                                    print(cubit.selectedScreenIndex);
                                    return cubit
                                        .screens[cubit.selectedScreenIndex];
                                  } else {
                                    return AppInitializer.startScreen;
                                  }
                                } else {
                                  return const WaitUpdateScreen();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                  debugShowCheckedModeBanner: false,
                );
              },
            ),
          );
        });
      }));
  }
}
