import 'package:dio/dio.dart';

class DioHelper {
  final Dio _dio;

  DioHelper({required Dio dio}) : _dio = dio;

  Dio configureDio() {
    _dio.options.connectTimeout = const Duration(seconds: 1000);
    _dio.options.receiveTimeout = const Duration(seconds: 10000);
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };
    _dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      requestHeader: false,
      responseHeader: false,
      error: true,
    ));
    return _dio;
  }
}