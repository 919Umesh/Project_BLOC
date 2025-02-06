import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bloc/core/core.dart';

class CreateProductRepository {
  Future<Response> createProduct({required FormData form}) async {
    debugPrint('-------formData----------');

    debugPrint('-------Form Data Fields----------');
    form.fields.forEach((field) {
      debugPrint('${field.key}: ${field.value}');
    });

    debugPrint('-------Form Data Files----------');
    if (form.files.isNotEmpty) {
      form.files.forEach((file) {
        debugPrint('${file.key}: ${file.value.filename}');
      });
    }
    String api = "/product/create";
    var response = await apiProvider.postFormDataAPI(endPoint: api, formData: form);
    return response;
  }
}