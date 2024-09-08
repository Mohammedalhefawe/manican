import 'package:dartz/dartz.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<Unit> cacheUserInfo(UserModel model);
  Future<String?> getCachedToken();
  Future<String?> getCachedRole();
  Future<int?> getCachedBranchId();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheUserInfo(UserModel model) {
    Map<String, dynamic> userToJson = model.toJson();
    sharedPreferences.setString("TOKEN", userToJson['authorisation']['token']);
    sharedPreferences.setString("ROLE", userToJson['user']['role']);
    sharedPreferences.setInt("BRANCH_ID", userToJson['user']['branch_id'] ?? 0);
    AppLink.branchId = (userToJson['user']['branch_id'] ?? 0).toString();
    // print(AppLink.branchId);
    return Future.value(unit);
  }

  @override
  Future<String?> getCachedRole() async {
    return sharedPreferences.getString("ROLE");
  }

  @override
  Future<String?> getCachedToken() async {
    return sharedPreferences.getString("TOKEN");
  }

  @override
  Future<int?> getCachedBranchId() async {
    return sharedPreferences.getInt("BRANCH_ID");
  }
}
