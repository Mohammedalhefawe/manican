import 'dart:convert';

import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/error/exceptions.dart';
import 'package:manicann/features/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserModel> login(String phoneNumber, String password);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});
  @override
  Future<UserModel> login(String email, String password) async {
    final body = {"email": email, "password": password};

    final response = await client.post(
      Uri.parse("${AppLink.baseUrl}auth/login"),
      body: body,
      //headers: {"Content-Type": "application/json"},
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      print(decodedJson["data"]);
      final UserModel userModel = UserModel.fromJson(decodedJson["data"]);
      return userModel;
    } else {
      throw ServerException();
    }
  }
}
