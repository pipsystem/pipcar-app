import '../configs/constants/string_constants.dart';

class ApiError implements Exception {
  final String? message;

  ApiError(this.message);

  @override
  String toString() {
    return message ?? StringConstants.msgErrorUnknown;
  }
}

class ExpiredTokenError implements Exception {
  final String? message;

  ExpiredTokenError(this.message);

  @override
  String toString() {
    return message ?? StringConstants.msgErrorUnknown;
  }
}

class ServerError implements Exception {
  final String? message;

  ServerError(this.message);

  @override
  String toString() {
    return message ?? StringConstants.msgErrorUnknown;
  }
}
