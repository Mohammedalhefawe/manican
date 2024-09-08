import 'dart:convert';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/booking/data/models/Services_employee_Model.dart';
import 'package:manicann/features/booking/data/models/available_time_model.dart';
import 'package:manicann/features/booking/data/models/users_model.dart';
import 'package:manicann/features/booking/domain/entities/booking_entity_data.dart';
import '../../../../core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class BookingRemoteDataSource {
  Future<ServiceEmployeeModel> getAllServicesAndEmployee();
  Future<List<AvailableTimeModel>> getAvaliableTime(
      String idService, String date);
  Future<List<UserModel>> getAllUsers();
  Future<Unit> addBooking(BookingEntity bookingEntitiy);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final http.Client client;
  BookingRemoteDataSourceImpl({required this.client});
  @override
  Future<ServiceEmployeeModel> getAllServicesAndEmployee() async {
    final response = await client.get(
      Uri.parse("${AppLink.baseUrl}branch/all/${AppLink.branchId}"),
    );

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      final Map<String, dynamic> decodedJson = data['data'];
      final ServiceEmployeeModel serviceModel =
          ServiceEmployeeModel.fromJson(decodedJson);
      return serviceModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    final response = await client.get(
      Uri.parse('${AppLink.baseUrl}user/index/${AppLink.branchId}'),
    );

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      final List decodedJson = data['data'];
      print(decodedJson.length);
      print(response.statusCode);
      print(response.body);
      final List<UserModel> availablesTimeModel = decodedJson
          .map(
            (json) => UserModel.fromJson(json),
          )
          .toList();
      return availablesTimeModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<AvailableTimeModel>> getAvaliableTime(
      String idService, String date) async {
    //${AppLink.baseUrl}operation/available-time/$idService?date=$date
    final response = await client.get(
      Uri.parse(
          '${AppLink.baseUrl}operation/available-time/$idService?date=$date'),
    );

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      final List decodedJson = data['data'];
      print(decodedJson.length);
      print('print availblrTime length ....');
      final List<AvailableTimeModel> availablesTimeModel = decodedJson
          .map(
            (json) => AvailableTimeModel.fromJson(json),
          )
          .toList();
      return availablesTimeModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addBooking(BookingEntity bookingEntitiy) async {
    final body = {
      'user_id': bookingEntitiy.userId,
      'branch_id': AppLink.branchId.toString(),
      'employee_id': bookingEntitiy.employeeId,
      'operation_id': bookingEntitiy.operationId,
      'date': bookingEntitiy.date,
      'time': bookingEntitiy.time
    };
    var request = http.MultipartRequest(
        'Post', Uri.parse("${AppLink.baseUrl}booking/store"));
    body.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
