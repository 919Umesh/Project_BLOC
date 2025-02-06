import 'dart:async';
import 'package:dio/dio.dart';
import 'package:project_bloc/core/core.dart';

class CreateProductRepository {
  Future<Response> createProduct({required FormData form}) async {
    String api = "/product/create";
    var response = await apiProvider.postFormDataAPI(endPoint: api, formData: form);
    return response;
  }
}