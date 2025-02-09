import '../../../../core/core.dart';
import '../model/product_list_model.dart';

class ProductListRepository {
  static Future<List<ProductModel>> getProductList() async {
    try {
      String api = "/product/get";
      var response = await apiProvider.getAPI(endPoint: api);
      ProductResponseModel productResponse = ProductResponseModel.fromJson(response);
      if (productResponse.status == 200) {
        return productResponse.products;
      } else {
        throw Exception(productResponse.message);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

