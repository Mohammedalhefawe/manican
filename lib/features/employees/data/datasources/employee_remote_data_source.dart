import 'dart:convert';
import 'package:manicann/features/employees/data/models/file_employee_model.dart';
import 'package:path/path.dart';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:manicann/features/employees/data/models/attendance_model.dart';
import 'package:manicann/features/employees/data/models/employee_model.dart';
import 'package:manicann/features/employees/data/models/service_model.dart';
import 'package:manicann/features/employees/domain/entities/file_attendance.dart';

import '../../../../core/constance/appLink.dart';
import '../../../../core/error/exceptions.dart';

abstract class EmployeeRemoteDataSource {
  Future<List<EmployeeModel>> getAllEmployees(int branchId);
  Future<EmployeeModel> getEmployeeDetails(int employeeId);
  Future<Unit> addEmployee(EmployeeModel employee, PlatformFile? image);
  Future<Unit> editEmployee(EmployeeModel employee, PlatformFile? image,
      List<int> addedIds, List<int> deletedIds);
  Future<Unit> deleteEmployee(int id);
  Future<FileResponseModel> downloadFileAttendance(
      DownloadFileEntity downloadFileEntity);
  Future<Unit> uploadFileAttendance(FileAttendanceEntity fileAttendanceEntity);
  Future<List<ServiceModel>> getAllServices(int id);
  Future<List<AttendanceModel>> getEmployeeAttendance(int id);
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final http.Client client;

  EmployeeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EmployeeModel>> getAllEmployees(int branchId) async {
    final response = await client
        .get(Uri.parse("${AppLink.baseUrl}employee/index/$branchId"));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      List employeesData = decodedJson['data'] as List;
      final List<EmployeeModel> employeesList = employeesData
          .map<EmployeeModel>(
              (jsonPostModel) => EmployeeModel.fromJson(jsonPostModel))
          .toList();
      return employeesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<EmployeeModel> getEmployeeDetails(int employeeId) async {
    final response = await client
        .get(Uri.parse("${AppLink.baseUrl}employee/show/$employeeId"));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      final EmployeeModel employeeModel =
          EmployeeModel.fromJson(decodedJson["data"]);
      return employeeModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<FileResponseModel> downloadFileAttendance(
      DownloadFileEntity downloadFileEntity) async {
    final http.Response response;
    if (downloadFileEntity.idEmployee != null) {
      response = await client.get(Uri.parse(
          "${AppLink.baseUrl}employee/report/${downloadFileEntity.idEmployee}?date=${downloadFileEntity.date}"));
    } else {
      response = await client.get(Uri.parse(
          "${AppLink.baseUrl}employee/reportAll/${AppLink.branchId}?date=${downloadFileEntity.date}"));
    }
    print(json.decode(response.body));
    print(response.statusCode);

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      final FileResponseModel employeeModel =
          FileResponseModel.fromJson(decodedJson["data"]);
      return employeeModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addEmployee(EmployeeModel employee, PlatformFile? image) async {
    final body = employee.toJson();
    const url = '${AppLink.baseUrl}auth/register';
    if (image != null) {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        image.bytes!,
        filename: image.name, // You can set any desired filename
      ));
      body.forEach((key, value) {
        request.fields[key] = value;
      });
      final response = await request.send();
      print(response.statusCode);
      // print(response.stream.bytesToString());
      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        // ignore: unused_local_variable
        // final responseBody = await response.stream.bytesToString();
        throw ServerException();
      }
    } else {
      final response = await client
          .post(Uri.parse("${AppLink.baseUrl}auth/register"), body: body);
      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<Unit> deleteEmployee(int id) async {
    final response =
        await client.delete(Uri.parse("${AppLink.baseUrl}user/delete/$id"));

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> uploadFileAttendance(
      FileAttendanceEntity fileAttendanceEntity) async {
    //${AppLink.baseUrl}attendance/file
    print('Loading.................');
    var request = http.MultipartRequest(
        'Post',
        Uri.parse(
            "${AppLink.baseUrl}attendance/file?branch_id=${AppLink.branchId}"));
    var multiFile = http.MultipartFile.fromBytes(
        'file', fileAttendanceEntity.file!,
        filename: basename(fileAttendanceEntity.filePath!));
    request.files.add(multiFile);
    // request.fields.addAll({'': AppLink.branchId});
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    print('Loaded.................');
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> editEmployee(
    EmployeeModel employee,
    PlatformFile? image,
    List<int> addedIds,
    List<int> deletedIds,
  ) async {
    final body = employee.toJson();
    for (int i = 0; i < addedIds.length; i++) {
      body.addAll({"services[$i]": "${addedIds[i]}"});
    }
    for (int i = 0; i < deletedIds.length; i++) {
      body.addAll({"deleted_services[$i]": "${deletedIds[i]}"});
    }
    body.addAll({"_method": "PUT"});

    final url = '${AppLink.baseUrl}employee/update/${employee.id}';
    if (image != null) {
      final request = http.MultipartRequest('PUT', Uri.parse(url));
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        image.bytes!,
        filename: image.name, // You can set any desired filename
      ));
      body.forEach((key, value) {
        request.fields[key] = value;
      });
      final response = await request.send();
      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        // ignore: unused_local_variable
        final responseBody = await response.stream.bytesToString();
        throw ServerException();
      }
    } else {
      final response = await client.put(Uri.parse(url), body: body);

      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<List<ServiceModel>> getAllServices(int id) async {
    final response =
        await client.get(Uri.parse("${AppLink.baseUrl}operation/index/$id"));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      List servicesData = decodedJson['data'] as List;
      final List<ServiceModel> servicesList = servicesData
          .map<ServiceModel>(
              (jsonPostModel) => ServiceModel.fromJson(jsonPostModel))
          .toList();
      return servicesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<AttendanceModel>> getEmployeeAttendance(int id) async {
    final response = await client
        .get(Uri.parse("${AppLink.baseUrl}attendance/user-attendance/$id"));
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      List attendanceData = decodedJson['data'] as List;
      final List<AttendanceModel> attendanceList = attendanceData
          .map<AttendanceModel>((jsonAttendanceModel) =>
              AttendanceModel.fromJson(jsonAttendanceModel))
          .toList();
      return attendanceList;
    } else {
      throw ServerException();
    }
  }
}
