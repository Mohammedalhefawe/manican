import 'dart:convert';
import 'package:path/path.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/offers/data/models/offer_model.dart';
import 'package:manicann/features/offers/domain/entities/offer_entity_data.dart';
import '../../../../core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class OfferRemoteDataSource {
  Future<List<OfferModel>> getAllOffers();
  Future<Unit> addOffer(OfferEntityData offerEntityData);
  Future<Unit> editOffer(OfferEntityData offerEntityData, String id);
  Future<Unit> deleteOffer(String id);
}

class OfferRemoteDataSourceImpl implements OfferRemoteDataSource {
  final http.Client client;

  OfferRemoteDataSourceImpl({required this.client});
  @override
  Future<List<OfferModel>> getAllOffers() async {
    final response = await client.get(
      Uri.parse("${AppLink.baseUrl}offer/index"),
    );

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      final List decodedJson = data['data'] as List;
      final List<OfferModel> offerModels = decodedJson
          .map<OfferModel>(
              (jsonOfferModel) => OfferModel.fromJson(jsonOfferModel))
          .toList();

      return offerModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addOffer(OfferEntityData offerEntityData) async {
    final body = {
      'title': offerEntityData.name,
      'description': offerEntityData.description,
    };
    var request = http.MultipartRequest(
        'Post', Uri.parse("${AppLink.baseUrl}offer/store"));
    var multiFile = http.MultipartFile.fromBytes(
        'image', offerEntityData.image!,
        filename: basename(offerEntityData.filePath!));
    request.files.add(multiFile);
    body.forEach((key, value) {
      request.fields[key] = value!;
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
  Future<Unit> deleteOffer(String id) async {
    var response =
        await client.delete(Uri.parse("${AppLink.baseUrl}offer/delete/$id"));
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> editOffer(OfferEntityData offerEntityData, String id) async {
    final body = {
      'title': offerEntityData.name,
      'description': offerEntityData.description,
      "_method": "put"
    };
    var request = http.MultipartRequest(
        'Post', Uri.parse("${AppLink.baseUrl}offer/update/$id"));
    var multiFile = http.MultipartFile.fromBytes(
        'image', offerEntityData.image!,
        filename: basename(offerEntityData.filePath!));
    request.files.add(multiFile);
    body.forEach((key, value) {
      request.fields[key] = value!;
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    print(response.statusCode);
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
