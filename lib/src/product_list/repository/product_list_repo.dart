import '../../../../core/core.dart';
import '../model/product_list_model.dart';

class ProductListRepository {
  static Future<List<ProductModel>> getProductList({required int page, required int limit}) async {
    try {
      String api = "/product/get";
      Map<String, dynamic> queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
      };
      var response = await apiProvider.getAPI(endPoint: api,queryParams: queryParams);
      ProductResponseModel productResponse = ProductResponseModel.fromJson(response);
      return productResponse.products;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
