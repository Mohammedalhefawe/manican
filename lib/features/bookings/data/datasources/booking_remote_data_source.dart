import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:manicann/features/clients/data/models/booking_model.dart';
import 'package:manicann/features/employees/data/models/file_employee_model.dart';
import 'package:manicann/features/employees/domain/entities/file_attendance.dart';
import '../../../../core/constance/appLink.dart';
import '../../../../core/error/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class BookingsRemoteDataSource {
  Future<List<BookingModel>> getAllCurrentBookings({required int branchId});
  Future<List<BookingModel>> getAllArchivedBookings({required int branchId});
  Future<Unit> acceptBooking({required int bookingId});
  Future<Unit> declineBooking({required int bookingId});
  Future<FileResponseModel> downloadFileAttendance(
      DownloadFileEntity downloadFileEntity);
}

class BookingsRemoteDataSourceImpl implements BookingsRemoteDataSource {
  final http.Client client;

  BookingsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BookingModel>> getAllCurrentBookings(
      {required int branchId}) async {
    final response = await client
        .get(Uri.parse("${AppLink.baseUrl}booking/recent/$branchId"));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      List currentBookingsData = decodedJson['data'] as List;
      final List<BookingModel> currentBookingsList = currentBookingsData
          .map<BookingModel>(
              (jsonBookingModel) => BookingModel.fromJson(jsonBookingModel))
          .toList();
      return currentBookingsList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<FileResponseModel> downloadFileAttendance(
      DownloadFileEntity downloadFileEntity) async {
    final http.Response response = await client.get(Uri.parse(
        "${AppLink.baseUrl}booking/reportAll/${AppLink.branchId}?date=${downloadFileEntity.date}"));

    print(json.decode(response.body));
    print(response.statusCode);

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      final FileResponseModel bookingModel =
          FileResponseModel.fromJson(decodedJson["data"]);
      return bookingModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<BookingModel>> getAllArchivedBookings(
      {required int branchId}) async {
    final response = await client
        .get(Uri.parse("${AppLink.baseUrl}booking/archive/$branchId"));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      List archivedBookingsData = decodedJson['data'] as List;
      final List<BookingModel> archivedBookingsList = archivedBookingsData
          .map<BookingModel>(
              (jsonBookingModel) => BookingModel.fromJson(jsonBookingModel))
          .toList();
      return archivedBookingsList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> acceptBooking({required int bookingId}) async {
    final response = await client
        .put(Uri.parse("${AppLink.baseUrl}booking/accept/$bookingId"));

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> declineBooking({required int bookingId}) async {
    final response = await client
        .put(Uri.parse("${AppLink.baseUrl}booking/decline/$bookingId"));

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
