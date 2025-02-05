class LoginApiResponse<T> {
  final int statusCode;
  final bool status;
  final String message;

  final List<T> data;

  LoginApiResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return LoginApiResponse<T>(
      data: json["data"] == null
          ? []
          : List<T>.from(json['data'].map((x) => fromJson(x))),
      statusCode: json["status_code"] ?? 0,
      status: json["status"] ?? false,
      message: json["message"] ?? "",
    );
  }
}

class ApiResponse<T> {
  final int status;
  final String message;
  final List<T> data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return ApiResponse<T>(
      status: json["status"] ?? 0,
      message: json["message"] ?? "",
      data: json["projects"] == null
          ? []
          : List<T>.from(json["projects"].map((x) => fromJson(x))),
    );
  }
}


class OtpResponse<T> {
  final int statusCode;
  final bool status;
  final String message;

  final List<T> data;

  OtpResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory OtpResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return OtpResponse<T>(
      data: json["data"] == null
          ? []
          : List<T>.from(json['data'].map((x) => fromJson(x))),
      statusCode: json["status_code"] ?? 0,
      status: json["status"] ?? false,
      message: json["Message"] ?? "",
    );
  }
}

class BasicModel {
  final String message;
  final int status;
  final String data;

  BasicModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory BasicModel.fromJson(Map<String, dynamic> json) {
    return BasicModel(
      message: json["message"] ?? "",
      status: json["status"] ?? 0,
      data: json["data"] ?? "",
    );
  }
  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data,
    "status": status,
  };
}
