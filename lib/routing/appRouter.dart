import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manicann/features/branches/presentation/pages/all_branches_screen.dart';

import 'package:manicann/routing/appRoute.dart';

class AppRouter {
  final GoRouter goRouter;

  static late AppRouter _appRouter;

  static init() {
    _appRouter = AppRouter();
  }

  AppRouter() : goRouter = _getRouter;

  static get getRouter => _appRouter.goRouter;

  static get _getRouter => GoRouter(
        initialLocation: AppRoute.home,
        observers: [],
        errorBuilder: (context, state) => const BranchesScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: AppRoute.signIn,
            builder: (BuildContext context, GoRouterState state) {
              return const BranchesScreen();
            },
          ),
        ],
      );
}
