import 'dart:convert';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/before_after/data/models/before_after_model.dart';
import 'package:manicann/features/before_after/domain/entities/before_after_entity_data.dart';
import '../../../../core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

abstract class BeforeAfterRemoteDataSource {
  Future<List<BeforeAfterModel>> getAllBeforeAfter();
  Future<Unit> addBeforeAfter(BeforeAfterEntityData beforeAfterEntityData);
  Future<Unit> editBeforeAfter(BeforeAfterEntityData beforeAfterEntityData);
  Future<Unit> deleteBeforeAfter(String idBeforAfter);
}

class BeforeAfterRemoteDataSourceImpl implements BeforeAfterRemoteDataSource {
  final http.Client client;
  BeforeAfterRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BeforeAfterModel>> getAllBeforeAfter() async {
    final response = await client.get(
      Uri.parse("${AppLink.baseUrl}user/before-after-images-without-paginate"),
    );

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      final List decodedJson = data['data'] as List;
      final List<BeforeAfterModel> beforeAfterModels = decodedJson
          .map<BeforeAfterModel>((jsonBeforeAfterModel) =>
              BeforeAfterModel.fromJson(jsonBeforeAfterModel))
          .toList();
      return beforeAfterModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteBeforeAfter(String idBeforAfter) async {
    final response = await client.delete(
      Uri.parse(
          "${AppLink.baseUrl}user/delete-before-after-images/$idBeforAfter"),
    );

    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addBeforeAfter(
      BeforeAfterEntityData beforeAfterEntityData) async {
    final body = {
      'description': beforeAfterEntityData.description,
      'images[0][type]': 'before',
      'images[1][type]': 'after',
    };
    var request = http.MultipartRequest(
        'Post',
        Uri.parse(
            "${AppLink.baseUrl}user/store-images/${AppLink.branchId.toString()}"));
    var multiFileBefore = http.MultipartFile.fromBytes(
        'images[0][image]', beforeAfterEntityData.imageBefore!,
        filename: basename(beforeAfterEntityData.filePathBefore!));
    var multiFileAfter = http.MultipartFile.fromBytes(
        'images[1][image]', beforeAfterEntityData.imageAfter!,
        filename: basename(beforeAfterEntityData.filePathAfter!));
    request.files.add(multiFileBefore);
    request.files.add(multiFileAfter);
    body.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> editBeforeAfter(
      BeforeAfterEntityData beforeAfterEntityData) async {
    final body = {
      'description': beforeAfterEntityData.description,
      'images[0][type]': 'before',
      'images[1][type]': 'after',
    };
    var request = http.MultipartRequest(
        'Post',
        Uri.parse(
            "${AppLink.baseUrl}user/edit-images/${AppLink.branchId.toString()}"));
    var multiFileBefore = http.MultipartFile.fromBytes(
        'images[0][image]', beforeAfterEntityData.imageBefore!,
        filename: basename(beforeAfterEntityData.filePathBefore!));
    var multiFileAfter = http.MultipartFile.fromBytes(
        'images[1][image]', beforeAfterEntityData.imageAfter!,
        filename: basename(beforeAfterEntityData.filePathAfter!));
    request.files.add(multiFileBefore);
    request.files.add(multiFileAfter);
    body.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
