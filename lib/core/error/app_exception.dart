class AppException implements Exception {
  final String message;
  final String prefix;
  final String url;

  AppException({
    required this.message,
    required this.prefix,
    required this.url,
  });
}

class OnSocketExpection extends AppException {
  OnSocketExpection({required super.message, required super.url})
      : super(prefix: "Socket Expection");
}

class OnTimeoutExpection extends AppException {
  OnTimeoutExpection({required super.message, required super.url})
      : super(prefix: "Request Timeout");
}

class OnBadRequestException extends AppException {
  OnBadRequestException({required super.message, required super.url})
      : super(prefix: "Bad Request");
}

class OnUnauthorizedRequestException extends AppException {
  OnUnauthorizedRequestException({required super.message, required super.url})
      : super(prefix: "Unauthorized Request");
}
