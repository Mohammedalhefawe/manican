import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:manicann/features/complaints/data/models/complaint_model.dart';
import '../../../../core/constance/appLink.dart';
import '../../../../core/error/exceptions.dart';

abstract class ComplaintsRemoteDataSource {
  Future<List<ComplaintModel>> getAllComplaints({required int branchId});
  Future<Unit> hideComplaint({required int complaintId});
}

class ComplaintsRemoteDataSourceImpl implements ComplaintsRemoteDataSource {
  final http.Client client;

  ComplaintsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ComplaintModel>> getAllComplaints({required int branchId}) async {
    final response = await client
        .get(Uri.parse("${AppLink.baseUrl}complaint/index/$branchId"));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      List complaintsData = decodedJson['data'] as List;
      final List<ComplaintModel> complaintsList = complaintsData
          .map<ComplaintModel>(
              (jsonPostModel) => ComplaintModel.fromJson(jsonPostModel))
          .toList();
      return complaintsList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> hideComplaint({required int complaintId}) async {
    final response = await client.delete(
      Uri.parse(
          "${AppLink.baseUrl}complaint/delete?complaint_id[0]=$complaintId}"),
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
