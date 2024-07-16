import 'dart:convert';
import 'dart:io';

import 'package:manican/core/constance/appLink.dart';
import 'package:manican/features/offers/data/models/post_model.dart';

import '../../../../core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class OfferRemoteDataSource {
  Future<List<OfferModel>> getAllOffers();
  Future<Unit> addOffer(String title, String description, File? image);
}

class OfferRemoteDataSourceImpl implements OfferRemoteDataSource {
  final http.Client client;

  OfferRemoteDataSourceImpl({required this.client});
  @override
  Future<List<OfferModel>> getAllOffers() async {
    final response = await client.get(
      Uri.parse(AppLink.baseUrl + "/Offers"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<OfferModel> OfferModels = decodedJson
          .map<OfferModel>(
              (jsonOfferModel) => OfferModel.fromJson(jsonOfferModel))
          .toList();

      return OfferModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addOffer(String title, String description, File? image) async {
    final body = {
      "title": title,
      "description": description,
    };

    final response =
        await client.post(Uri.parse(AppLink.baseUrl + "/Offers"), body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
