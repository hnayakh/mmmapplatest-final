import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';

class ApiClient {
  final Dio dio = Dio();

  ApiClient() {
    dio.interceptors.add(dioLoggerInterceptor);
  }
}
