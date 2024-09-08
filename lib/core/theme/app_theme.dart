import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData get appTheme => ThemeData(
    brightness: Brightness.light,
    fontFamily: "Cairo",
    textTheme: textTheme,
    primaryColor: AppColors.primary,
    appBarTheme:
        const AppBarTheme(iconTheme: IconThemeData(color: Colors.black)));

TextTheme get textTheme => TextTheme(
      displayLarge: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: AppColors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
    );
