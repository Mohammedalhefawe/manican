import 'package:manicann/di/injectionContainer.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppLink {
  // static const String baseUrl = 'http://localhost:8000/api/';
  // static const String imageBaseUrl = 'http://localhost:8000/storage/';

  static const String baseUrl = 'http://161.35.27.202:8099/api/';
  static const String imageBaseUrl = 'http://161.35.27.202:8099/storage/';
  static String baseImageUrl =
      'https://www.brighterdaysgriefcenter.org/wp-content/uploads/2017/01/team.jpg';
  static String token = 'TOKEN';
  static String role = "";
  static String branchId =
      di.sl<SharedPreferences>().getString('branchId') ?? '1';
}
