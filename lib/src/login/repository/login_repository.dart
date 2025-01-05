import 'dart:convert';
import 'package:project_bloc/src/login/model/login_model.dart';
import '../../../core/model/api_response_model.dart';
import '../../../core/services/api/api_helper.dart';

class LoginRepository {
  Future<BasicModel> loginUser({
    required LoginModel user,
  }) async {
    try {
      String api = "/users/loginUser";
      var body = jsonEncode({
        "email": user.email,
        "password": user.password
      });

      var response = await apiProvider.postAPI(endPoint: api, body: body);
      final result = jsonDecode(response);
      return BasicModel.fromJson(result);
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
