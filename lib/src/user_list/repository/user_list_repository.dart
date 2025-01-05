import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_bloc/src/user_list/model/user_list_model.dart';

import '../../../../core/core.dart';

class UserListRepository {
  static Future<List<UserModel>> getUserList() async {
    try {
      String api = "/users/getUsers";

      var response = await apiProvider.getAPI(endPoint: api);
      debugPrint("API=> $api");
      debugPrint("RESPONSE=> $response");
      ApiResponse<UserModel> apiResponse = ApiResponse<UserModel>.fromJson(
        jsonDecode(response),
            (json) => UserModel.fromJson(json),
      );
      if (apiResponse.status == 200) {
        return apiResponse.data;
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

