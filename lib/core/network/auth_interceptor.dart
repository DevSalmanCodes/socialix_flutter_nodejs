import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final AuthService authService;
  AuthInterceptor({
    required this.dio,
   required this.authService
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (authService.accessToken != null) {
      await authService.ensureTokenIsValid();
      options.headers['Authorization'] = 'Bearer ${authService.accessToken}';
    } else {
      options.headers['Authorization'] = 'Bearer ${authService.accessToken}';
    }

    handler.next(options);
  }
}
