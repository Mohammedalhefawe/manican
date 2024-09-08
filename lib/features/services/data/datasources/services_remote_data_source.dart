import 'dart:convert';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/services/data/models/services_model.dart';
import 'package:manicann/features/services/domain/entities/service_discount_entity_data.dart';
import 'package:manicann/features/services/domain/entities/service_entity_data.dart';
import '../../../../core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

abstract class ServiceRemoteDataSource {
  Future<List<ServiceModel>> getAllServices();
  Future<Unit> addService(ServiceEntityData serviceEntityData);
  Future<Unit> editService(ServiceEntityData serviceEntityData);
  Future<Unit> addDiscount(ServiceDiscountEntity serviceDiscountEntity);
  Future<Unit> addSpecialist();
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final http.Client client;
  ServiceRemoteDataSourceImpl({required this.client});
  @override
  Future<List<ServiceModel>> getAllServices() async {
    final response = await client.get(
      Uri.parse("${AppLink.baseUrl}operation/index/${AppLink.branchId}"),
    );

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      final List decodedJson = data['data'] as List;
      final List<ServiceModel> serviceModels = decodedJson
          .map<ServiceModel>(
              (jsonServiceModel) => ServiceModel.fromJson(jsonServiceModel))
          .toList();
      return serviceModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addService(ServiceEntityData serviceEntityData) async {
    final body = {
      'name': serviceEntityData.name,
      'price': serviceEntityData.price,
      'from': serviceEntityData.from,
      'to': serviceEntityData.to,
      'period': serviceEntityData.period,
      'branch_id': serviceEntityData.branchId,
    };
    var request = http.MultipartRequest(
        'Post', Uri.parse("${AppLink.baseUrl}operation/store"));
    var multiFile = http.MultipartFile.fromBytes(
        'image', serviceEntityData.image!,
        filename: basename(serviceEntityData.filePath!));
    request.files.add(multiFile);
    body.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addDiscount(ServiceDiscountEntity serviceDiscountEntity) async {
    final body = {
      'value': serviceDiscountEntity.value,
      'to': serviceDiscountEntity.to,
      'from': serviceDiscountEntity.from,
    };
    for (var i = 0; i < serviceDiscountEntity.services.length; i++) {
      body['services[$i]'] = serviceDiscountEntity.services[i].toString();
    }
    var request = http.MultipartRequest(
        'Post',
        Uri.parse(
            "${AppLink.baseUrl}operation/create-discount/${AppLink.branchId}"));
    body.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addSpecialist() {
    // TODO: implement addSpecialist
    throw UnimplementedError();
  }

  @override
  Future<Unit> editService(ServiceEntityData serviceEntityData) {
    // TODO: implement editService
    throw UnimplementedError();
  }
}
