import 'dart:convert';
import 'package:project_bloc/app/constant/api_endpoints.dart';
import 'package:project_bloc/src/login/model/login_model.dart';
import '../../../core/model/api_response_model.dart';
import '../../../core/services/api/api_helper.dart';

class LoginRepository {
  Future<BasicModel> loginUser({
    required LoginModel user,
  }) async {
    try {
      var body = jsonEncode({
        "email": user.email,
        "password": user.password
      });
      var response = await apiProvider.postAPI(endPoint: ApiEndpoints.getUserLogin, body: body);
      final result = jsonDecode(response);
      return BasicModel.fromJson(result);
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
