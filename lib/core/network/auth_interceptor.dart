import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService authService;
  final Dio dio;
  AuthInterceptor({required this.authService, required this.dio});
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = authService.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response?.statusCode == 401 && authService.refreshToken != null) {
        final newAccessToken = await _refreshAccessToken();
        if (newAccessToken != null) {
          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';
        }
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      }
    } catch (_) {
      await authService.clearTokens();
    }
    return handler.next(err);
  }

  Future<String?> _refreshAccessToken() async {
    final refreshToken = authService.refreshToken;
    final res = await dio.post(
      '/user/refesh-token',
      data: {'refreshToken': refreshToken},
    );
    final newAccessToken = res.data['newAccessToken'];
    final newRefreshToken = res.data['newRefreshToken'];
    await authService.saveTokens(newRefreshToken, newRefreshToken);
    return newAccessToken;
  }
}
