import 'package:dio/dio.dart';

class DioClient {
  static Dio createDio(){
    final dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));
    return dio;
  }
}