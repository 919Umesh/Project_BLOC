import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bloc/app/constant/api_endpoints.dart';
import 'package:project_bloc/core/core.dart';

class CreateProductRepository {
  Future<Response> createProduct({required FormData form}) async {
    var response = await apiProvider.postAPIUnified(
        endPoint: ApiEndpoints.createProduct,
        needsAuthorization: false,
        iSJsonDataHeaderType: false,
        formData: form);
    return response;
  }
  Future<Response> updateProduct({required FormData form,required String id}) async {
    String api ='/product/update/$id';
    Fluttertoast.showToast(msg: api);
    var response = await apiProvider.putAPIUnified(
        endPoint: api,
        needsAuthorization: false,
        iSJsonDataHeaderType: false,
        formData: form);
    return response;
  }
}

final CreateProductRepository createProductRepository = CreateProductRepository();
