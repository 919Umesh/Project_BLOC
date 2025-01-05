// import 'dart:convert';
// import '../../../../core/core.dart';
//
// class CreateProjectRepository {
//   static Future<bool> login({
//     required String name,
//     required String duration,
//     required String location,
//     required String members,
//     required String amount,
//     required List<String> status,
//
//   }) async {
//     String api = "project/create?name=$name&duration=$duration&members=$members&location=$location&amount=$amount&status=$status";
//
//     var response = await apiProvider.getAPI(endPoint: api);
//
//     final result = jsonDecode(response);
//
//     if ("${result['data']}".toLowerCase() != "aready exists") {
//       return true;
//     }
//     else {
//       throw Exception("User Already Exists");
//     }
//   }
// }
// create_project_repository.dart
import 'dart:convert';

import 'package:project_bloc/core/services/api/api_helper.dart';


class CreateProjectRepository {

  Future<bool> createProject({
    required String name,
    required String duration,
    required String location,
    required String members,
    required String amount,
    required String status,
  }) async {
    try {

      final response = await apiProvider.getAPI(
        endPoint: 'project/create',

      );

      final result = jsonDecode(response);

      if (result['data']?.toString().toLowerCase() == "already exists") {
        throw Exception("Project Already Exists");
      }

      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}