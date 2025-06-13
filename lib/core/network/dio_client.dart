import 'package:dio/dio.dart';
class DioClient {
  static Dio createDio() {
    final dio = Dio();
    return dio;
  }
}
