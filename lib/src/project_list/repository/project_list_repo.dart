import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bloc/src/project_list/model/project_list_model.dart';
import '../../../../core/core.dart';

class ProjectListRepository {
  static Future<List<ProjectModel>> getProjectList(
      {required String status}) async {
    try {
      String api = "/project/get?status=$status";
      var response = await apiProvider.getAPI(endPoint: api);
      // ProjectResponseModel projectResponse = ProjectResponseModel.fromJson(response);
      var responseJson = jsonDecode(response);
      ProjectResponseModel projectResponse = ProjectResponseModel.fromJson(responseJson);
      if (projectResponse.status == 200) {
        return projectResponse.projects;
      } else {

        throw Exception(projectResponse.message);
      }
    } catch (e) {
      debugPrint('-------------dgbdg-------');
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }
}

