import '../../../../core/core.dart';
import '../model/product_list_model.dart';

class ProductListRepository {
  static Future<List<ProductModel>> getProjectList(
      {required String status}) async {
    try {
      String api = "/project/get?status=$status";
      var response = await apiProvider.getAPI(endPoint: api);
      ProductResponseModel projectResponse = ProductResponseModel.fromJson(response);
      if (projectResponse.status == 200) {
        return projectResponse.projects;
      } else {
        throw Exception(projectResponse.message);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

