class AuthErrorHandler {
  int? statusCode;
  String? message;

  AuthErrorHandler({this.statusCode, this.message});

  AuthErrorHandler.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }
}
