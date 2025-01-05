import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  Future getAPI({required String endPoint}) async {
    try {
      String api = await locator<PrefHelper>().getBaseUrl() + endPoint;
      var headers = {'Content-Type': 'application/json'};
      http.Response response = await http
          .get(Uri.parse(api), headers: headers)
          .timeout(const Duration(seconds: 20));

      debugPrint("API=> $api\nRESPONSE=> ${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    }
    //
    on SocketException {
      return jsonEncode(APIConstants.errorNetworkMap);
    }
    //
    on TimeoutException {
      return jsonEncode(APIConstants.errorTimeoutMap);
    }
    //
    catch (e) {
      debugPrint("API ERROR $e");

      return jsonEncode(APIConstants.errorMap);
    }
  }

  /// [ postAPI ] used to handle all [ POST ]  api call
  Future postAPI({required String endPoint, required String body}) async {
    var headers = {'Content-Type': 'application/json'};

    try {
      String api = await locator<PrefHelper>().getBaseUrl() + endPoint;
      http.Response response = await http
          .post(Uri.parse(api), headers: headers, body: body)
          .timeout(const Duration(seconds: 30));
      debugPrint("API=> $api\nRESPONSE=> ${jsonDecode(response.body)}");
      if (response.statusCode == 201) {
        return response.body;
      } else {
        return response.body;
      }
    }
    //
    on SocketException {
      return jsonEncode(APIConstants.errorNetworkMap);
    }
    //
    on TimeoutException {
      return jsonEncode(APIConstants.errorTimeoutMap);
    }
    //
    catch (e) {
      debugPrint("API ERROR $e");

      return jsonEncode(APIConstants.errorMap);
    }
  }

  ///
}
