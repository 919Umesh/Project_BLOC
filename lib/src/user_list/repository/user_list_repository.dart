import 'dart:convert';
import 'package:project_bloc/src/user_list/db/user_list_db.dart';
import 'package:project_bloc/src/user_list/model/user_list_model.dart';
import '../../../../core/core.dart';

class UserListRepository {
  static Future<List<UserModel>> getUserList() async {
    try {
      String api = "/users/getUsers";

      var response = await apiProvider.getAPI(endPoint: api);
      UsersResponseModel userListResponse = UsersResponseModel.fromJson(response);
      if (userListResponse.status == 200) {
        return userListResponse.users;
      } else {
        throw Exception(userListResponse.message);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<List<UserModel>> getUserNameList() async {
    return await UserListDatabase.instance.getDataList();
  }
}

