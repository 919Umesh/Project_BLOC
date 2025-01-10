import 'dart:convert';
import '../../../../core/core.dart';
import '../model/create_project_model.dart';

class CreateProjectRepository {
   Future<BasicModel> createProject({
    required Project product,
  }) async {

    String api = "/project/create";
    var body = jsonEncode({
      "name": product.name,
      "duration": product.duration,
      "location": product.location,
      "members": product.members,
      "amount":product.amount,
      "status": product.status
    });
    var response = await apiProvider.postAPI(endPoint: api,body: body);
    final result = jsonDecode(response);
    return BasicModel.fromJson(result);
  }
}
//http://localhost:3000/project/search?name=Project H