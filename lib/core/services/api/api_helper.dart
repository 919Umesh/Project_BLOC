import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bloc/app/constant/api_endpoints.dart';
import 'package:project_bloc/app/temp/custom_log.dart';
import 'package:project_bloc/core/injection/injection_helper.dart';
import 'package:project_bloc/core/services/api/api_constants.dart';

final apiProvider = locator<APIProvider>();

class APIProvider {
  static final APIProvider _instance = APIProvider._internal();

  factory APIProvider() {
    return _instance;
  }

  APIProvider._internal();

  /// [ getAPI ] used to handle all [ GET ] api call
  Future getAPI(
      {required String endPoint,
      Map<String, dynamic>? queryParams,
      String? authToken}) async {
    try {
      String api = ApiEndpoints.baseURL + endPoint;
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

      Response response = await dio.get(
        api,
        queryParameters: queryParams,
      );

      _logRequest(api, response.data, queryParams);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        CustomLog.errorLog(value: response.data);
        throw Exception(
            "Failed to fetch data. Status Code: ${response.statusCode}");
      }
    }
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
      String api = ApiEndpoints.baseURL + endPoint;
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
    String api = ApiEndpoints.baseURL + endPoint;
    Dio dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ));
    Response? result;
    try {
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
    } on SocketException catch (e) {
      return Fluttertoast.showToast(msg: e.toString());
    }
    return result!;
  }

  Future<dynamic> postAPIUnified({
    required String endPoint,
    String? body,
    FormData? formData,
    bool needsAuthorization = false,
    bool defaultSnackbar = true,
    bool changeBaseUrl = false,
    String? changedBaseUrl,
    bool iSJsonDataHeaderType = false,
  }) async {
    try {
      String api = (changeBaseUrl && changedBaseUrl != null)
          ? "$changedBaseUrl$endPoint"
          : "${ApiEndpoints.baseURL}$endPoint";

      Dio dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ));

      if (needsAuthorization) {
        String token = "";
        // String token = await SharedPreferencesHelper.getString(
        //     key: SharedPreferenceKey.token);
        if (token.isNotEmpty) {
          dio.options.headers["Authorization"] = "Token $token";
        }
      }

      dio.options.headers['Content-Type'] =
          iSJsonDataHeaderType ? 'application/json' : 'multipart/form-data';

      Response response;

      if (formData != null) {
        response = await dio.post(api, data: formData);
      } else if (body != null) {
        response = await dio.post(api, data: body);
      } else {
        throw ArgumentError("Either 'body' or 'formData' must be provided.");
      }

      CustomLog.successLog(value: "API=> $api\nRESPONSE=> ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonEncode(response.data);
      } else {
        return jsonEncode(response.data);
      }
    } on DioException catch (e) {
      debugPrint('Dio ERROR: ${e.message}');
      debugPrint('Dio ERROR RESPONSE: ${e.response}');

      if (e.error is SocketException) {
        if (defaultSnackbar) {
          Fluttertoast.showToast(msg: "Network Error");
        }
        return jsonEncode(APIConstants.errorNetworkMap);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        if (defaultSnackbar) {
          Fluttertoast.showToast(msg: "Request Timeout");
        }
        return jsonEncode(APIConstants.errorTimeoutMap);
      } else {
        if (defaultSnackbar) {
          Fluttertoast.showToast(msg: "Something went wrong");
        }
        return jsonEncode(APIConstants.errorMap);
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      if (defaultSnackbar) {
        Fluttertoast.showToast(msg: "No Internet Connection");
      }
      return jsonEncode(APIConstants.errorNetworkMap);
    } catch (e) {
      debugPrint("API ERROR: $e");
      if (defaultSnackbar) {
        Fluttertoast.showToast(msg: "An unexpected error occurred");
      }
      return jsonEncode(APIConstants.errorMap);
    }
  }

  static void _logRequest(
    String api,
    dynamic response,
    dynamic queryParams,
  ) {
    CustomLog.actionLog(value: "\n");
    CustomLog.warningLog(value: "API      : [$api]");
    CustomLog.successLog(value: "RESPONSE : $response");
    CustomLog.warningLog(value: "Query : $queryParams");
    CustomLog.actionLog(value: "\n");
  }
}
