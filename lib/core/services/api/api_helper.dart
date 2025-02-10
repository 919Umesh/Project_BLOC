import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bloc/app/temp/custom_log.dart';
import 'package:project_bloc/core/injection/injection_helper.dart';
import 'package:project_bloc/core/services/api/api_constants.dart';
import 'package:project_bloc/core/services/sharepref/share_pref.dart';

final apiProvider = locator<APIProvider>();

class APIProvider {
  static final APIProvider _instance = APIProvider._internal();

  factory APIProvider() {
    return _instance;
  }

  APIProvider._internal();

  /// [ getAPI ] used to handle all [ GET ] api call
  Future getAPI({required String endPoint,Map<String, dynamic>? queryParams, String? authToken}) async {
    try {
      String api = await locator<PrefHelper>().getBaseUrl() + endPoint;
      var headers = {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

      Dio dio = Dio(BaseOptions(
        headers: headers,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
      ));

      Response response = await dio.get(api, queryParameters: queryParams,);

      CustomLog.successLog(value: "API=> $api\n Query=> $queryParams \nRESPONSE=> ${response.data}");

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg:response.statusMessage.toString());
        CustomLog.successLog(value: "RESPONSE=> ${response.data}");
        return response.data;
      } else {
        CustomLog.errorLog(value: response.data);
        throw Exception("Failed to fetch data. Status Code: ${response.statusCode}");
      }
    }
    //
    on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return jsonEncode(APIConstants.errorTimeoutMap);
      } else if (e.error is SocketException) {
        return jsonEncode(APIConstants.errorNetworkMap);
      } else {
        debugPrint("Dio ERROR ${e.message}");
        return jsonEncode(APIConstants.errorMap);
      }
    }
    //
    catch (e) {
      debugPrint("API ERROR $e");
      return jsonEncode(APIConstants.errorMap);
    }
  }

  /// [ postAPI ] used to handle all [ POST ]  api call
  Future postAPI({required String endPoint, required String body}) async {
    try {
      String api = await locator<PrefHelper>().getBaseUrl() + endPoint;
      var headers = {'Content-Type': 'application/json'};

      Dio dio = Dio(BaseOptions(
        headers: headers,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ));

      Response response = await dio.post(
        api,
        data: body,
      );

      CustomLog.successLog(value: "API=> $api\nRESPONSE=> ${response.data}");

      if (response.statusCode == 201) {
        return jsonEncode(response.data);
      } else {
        return jsonEncode(response.data);
      }
    }
    //
    on DioException catch (e) {
      if (e.error is SocketException) {
        return jsonEncode(APIConstants.errorNetworkMap);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return jsonEncode(APIConstants.errorTimeoutMap);
      } else {
        debugPrint("Dio ERROR ${e.message}");
        return jsonEncode(APIConstants.errorMap);
      }
    }
    //
    catch (e) {
      debugPrint("API ERROR $e");
      return jsonEncode(APIConstants.errorMap);
    }
  }

  /// [postFormDataAPI] used to handle all [POST] API calls with FormData (multipart).
  Future postFormDataAPI({
    required String endPoint,
    required FormData formData,
  }) async {

      String api = await locator<PrefHelper>().getBaseUrl() + endPoint;
      Dio dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ));
      Response? result;
      try{
        result = await dio.post(
          api,
          data: formData,
        );
        CustomLog.successLog(value: "RESPONSE=> $result");
        debugPrint('----------result-----------');
        CustomLog.successLog(value: "RESPONSE=> ${result.data}");
      } on DioException catch (e) {
        debugPrint('\n postDataToServer error message : ${e.message}');
        debugPrint('\n postDataToServer error : ${e.error}');
        debugPrint('-------------gdf-------');
        Fluttertoast.showToast(msg: 'dfd');
        debugPrint('\n postDataToServer error response : ${e.response}');

      }
      on SocketException catch (e) {
        return Fluttertoast.showToast(msg: e.toString());
      }
      return result!;
    }
  }
