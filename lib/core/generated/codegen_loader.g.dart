// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "no_connection": "No internet connection",
  "login": "Login",
  "email": "Email",
  "password": "Password",
  "email_validation_message": "You should enter your email",
  "home": "Home",
  "change_language": "Change Language",
  "next": "Next",
  "previous": "Previous",
};
static const Map<String,dynamic> ar = {
  "no_connection": "لا يوجد اتصال بالإنترنت",
  "login": "تسجيل الدخول",
  "email": "البريد الألكتروني",
  "password": "كلمة السر",
  "email_validation_message": "يجب عليك ادخال البريد الالكتروني",
  "home": "الرئيسية",
  "change_language": "تغيير اللغة",
  "next": "التالي",
  "previous": "السابق",
  
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ar": ar};
}
