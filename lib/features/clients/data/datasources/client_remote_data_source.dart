import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manicann/features/clients/data/models/booking_model.dart';
import 'package:manicann/features/clients/data/models/booking_percentage_model.dart';
import 'package:manicann/features/clients/domain/entities/client_booking_percentage.dart';
import '../../../../core/constance/appLink.dart';
import '../../../../core/error/exceptions.dart';
import '../models/client_model.dart';
import 'package:http/http.dart' as http;

abstract class ClientRemoteDataSource {
  Future<List<ClientModel>> getAllClients({required int branchId});
  Future<ClientModel> getClientDetails({required int clientId});
  Future<Unit> addClient(
      {required ClientModel clientModel, required PlatformFile? image});
  Future<Unit> editClient(
      {required ClientModel clientModel, required PlatformFile? image});
  Future<Unit> deleteClient({required int clientId});
  Future<List<BookingModel>> getCurrentBookings({required int clientId});
  Future<List<BookingModel>> getArchivedBookings({required int clientId});
  Future<Unit> acceptBooking({required int bookingId});
  Future<Unit> declineBooking({required int bookingId});
  Future<BookingPercentage> getBookingPercentage({required int clientId});
}

class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  final http.Client client;

  ClientRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ClientModel>> getAllClients({required int branchId}) async {
    final response =
        await client.get(Uri.parse("${AppLink.baseUrl}user/index/$branchId"));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      List clientsData = decodedJson['data'] as List;
      final List<ClientModel> clientsList = clientsData
          .map<ClientModel>(
              (jsonClientModel) => ClientModel.fromJson(jsonClientModel))
          .toList();
      return clientsList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ClientModel> getClientDetails({required int clientId}) async {
    final response =
        await client.get(Uri.parse("${AppLink.baseUrl}user/show/$clientId"));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      final ClientModel clientModel = ClientModel.fromJson(decodedJson["data"]);
      return clientModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addClient(
      {required ClientModel clientModel, required PlatformFile? image}) async {
    final body = clientModel.toJson();
    body.addAll({"role": "user"});
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
      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
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
  Future<Unit> deleteClient({required int clientId}) async {
    final response = await client
        .delete(Uri.parse("${AppLink.baseUrl}user/delete/$clientId"));

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> editClient({
    required ClientModel clientModel,
    required PlatformFile? image,
  }) async {
    final body = clientModel.toJson();
    body.addAll({"_method": "PUT"});

    final url = '${AppLink.baseUrl}user/update/${clientModel.id}';
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
  Future<List<BookingModel>> getCurrentBookings({required int clientId}) async {
    final response = await client
        .get(Uri.parse("${AppLink.baseUrl}booking/recent-with-user/$clientId"));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      List currentBookingsData =
          decodedJson['data'][0]['recent_customer_reservation'] as List;
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
  Future<List<BookingModel>> getArchivedBookings(
      {required int clientId}) async {
    final response = await client.get(
        Uri.parse("${AppLink.baseUrl}booking/archive-with-user/$clientId"));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      List currentBookingsData =
          decodedJson['data'][0]['archive_customer_reservation'] as List;
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

  @override
  Future<BookingPercentageModel> getBookingPercentage(
      {required int clientId}) async {
    final response = await client
        .get(Uri.parse("${AppLink.baseUrl}booking/user-percentage/$clientId"));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      final BookingPercentageModel percentage =
          BookingPercentageModel.fromJson(decodedJson["data"] ??
              {
                'user_percentage': 0,
                'other_percentage': 100,
              });
      return percentage;
    } else {
      throw ServerException();
    }
  }
}
