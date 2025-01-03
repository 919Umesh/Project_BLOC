class APIConstants {
  APIConstants._();

  static Map<String, dynamic> errorMap = {
    "status_code": 9999,
    "status": false,
    "message": "Something goes wrong."
  };
  static Map<String, dynamic> errorNetworkMap = {
    "status_code": 8888,
    "status": false,
    "message": "No Internet Connection."
  };
  static Map<String, dynamic> errorTimeoutMap = {
    "status_code": 7777,
    "status": false,
    "message": "Request Timeout."
  };

  static String defaultAPI =
      "http://192.168.1.67:3000/";
}
