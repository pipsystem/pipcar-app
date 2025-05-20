import 'package:dio/dio.dart';

class DioConfig {
  static final DioConfig _dioConfig = DioConfig._internal();

  factory DioConfig() {
    return _dioConfig;
  }

  DioConfig._internal();

  static Options dioConfigOption() {
    int timeRequest = 60;
    return Options(
        headers: {
          'Content-Type': 'application/json',
        },
        receiveTimeout: Duration(seconds: timeRequest),
        sendTimeout: Duration(seconds: timeRequest),
        responseType: ResponseType.json);
  }
}
