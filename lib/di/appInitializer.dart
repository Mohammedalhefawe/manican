import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/authentication/presentation/pages/login_page.dart';
import 'package:manicann/routing/appRouter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppInitializer {
  static Widget startScreen = LoginScreen();
  static bool isHaveAuth = false;
  static init() async {
    ///initialize EasyLocalization
    await EasyLocalization.ensureInitialized();

    ///initialize routing
    AppRouter.init();

    //init
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("TOKEN");
    String? role = sharedPreferences.getString("ROLE");
    int? branchId = sharedPreferences.getInt("BRANCH_ID");
    String? branchID = sharedPreferences.getString("branchId");
    print(branchID);
    print('branchID;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
    if (token != null && role != null && branchId != null) {
      AppLink.token = token;
      AppLink.role = role;
      AppLink.branchId = branchID ?? '0';
      isHaveAuth = true;
    }

    ///dependencies injection
    // await di.init();
  }
}
