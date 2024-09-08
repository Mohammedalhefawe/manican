import 'dart:convert';
import 'package:path/path.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/branches/data/models/branch_model.dart';
import 'package:manicann/features/branches/domain/entities/branch_entity.dart';
import '../../../../core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class BranchesRemoteDataSource {
  Future<List<BranchModel>> getAllBranches();
  Future<Unit> addBranch(BranchEntity branchEntity);
}

class BranchesRemoteDataSourceImpl implements BranchesRemoteDataSource {
  final http.Client client;

  BranchesRemoteDataSourceImpl({required this.client});
  @override
  Future<List<BranchModel>> getAllBranches() async {
    final response = await client.get(
        Uri.parse("${AppLink.baseUrl}branch/index"),
        headers: {'lang': 'ar'});

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      // print(data);
      final List decodedJson = data['data'] as List;
      final List<BranchModel> branchModels = decodedJson
          .map<BranchModel>(
              (jsonBranchModel) => BranchModel.fromJson(jsonBranchModel))
          .toList();

      return branchModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addBranch(BranchEntity branchEntity) async {
    final String workingDaysJson = jsonEncode(branchEntity.wokingDays);
    final body = {
      'name': branchEntity.name,
      'description': branchEntity.description,
      'start_time': branchEntity.startTime,
      'end_time': branchEntity.endTime,
      'location': branchEntity.location,
      'working_days': workingDaysJson,
    };
    print(basename(branchEntity.filePath!));
    var request = http.MultipartRequest(
        'Post', Uri.parse("${AppLink.baseUrl}branch/store"));
    var multiFile = http.MultipartFile.fromBytes('image', branchEntity.image!,
        filename: basename(branchEntity.filePath!));
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
}
