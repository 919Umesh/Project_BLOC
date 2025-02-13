import 'dart:async';
import 'package:dio/dio.dart';
import 'package:project_bloc/app/constant/api_endpoints.dart';
import 'package:project_bloc/core/core.dart';

class CreateProductRepository {
  Future<Response> createProduct({required FormData form}) async {
    var response = await apiProvider.postFormDataAPI(
        endPoint: ApiEndpoints.createProduct, formData: form);
    return response;
  }
}

final CreateProductRepository createProductRepository =
    CreateProductRepository();
