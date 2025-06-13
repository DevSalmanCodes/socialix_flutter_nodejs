import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService authService;
  final Dio dio;
  AuthInterceptor({required this.authService, required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = authService.accessToken;
    if (token != null && JwtDecoder.isExpired(token)) {
      await authService.ensureTokenIsValid();
      options.headers['Authorization'] = 'Bearer ${authService.accessToken}';
    } else {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
