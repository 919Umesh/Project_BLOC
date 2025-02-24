import 'package:project_bloc/app/constant/api_endpoints.dart';
import '../../../../core/core.dart';
import '../model/product_list_model.dart';

//Product List
class ProductListRepository {
  static Future<List<ProductModel>> getProductList(
      {required int page, required int limit}) async {
    try {
      var response = await apiProvider.getAPI(
          endPoint: ApiEndpoints.getProductList,
          queryParams: {
            'page': page,
            'limit': limit,
         });
      ProductResponseModel productResponse = ProductResponseModel.fromJson(response);
      return productResponse.products;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
