import '../../../../core/core.dart';
import '../model/product_list_model.dart';

class ProductListRepository {
  static Future<List<ProductModel>> getProductList() async {
    try {
      String api = "/product/get";
      var response = await apiProvider.getAPI(endPoint: api);
      ProductResponseModel productResponse = ProductResponseModel.fromJson(response);
      return productResponse.products;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

