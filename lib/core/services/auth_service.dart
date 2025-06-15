import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socialix_flutter_nodejs/core/constants/endpoints_constants.dart';
import 'package:socialix_flutter_nodejs/core/constants/storage_keys.dart';
import 'package:socialix_flutter_nodejs/features/user/data/models/user_model.dart';
import 'package:socialix_flutter_nodejs/injection/service_locator.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  String? _refreshToken;
  String? _accessToken;
  final Dio dio;
  AuthService({required this.dio});

  Future<void> init() async {
    await _loadTokensFromStorage();
    await _loadUserFromStorage();
  }

  Future<void> ensureTokenIsValid() async {
    if (_accessToken == null) return;
    final bool isTokenExpired = JwtDecoder.isExpired(_accessToken!);
    if (isTokenExpired && _accessToken != null) {
      await _refreshAccesToken();
    }
  }

  Future<void> _refreshAccesToken() async {
    final secureStorage = sl<FlutterSecureStorage>();
    if (_refreshToken == null) throw Exception('Invalid refresh Token');
    final res = await dio.post(
      '${EndpointsConstants.baseUrl}/auth/refresh-token',
      data: {'refreshToken': _refreshToken},
    );
    final accessToken = res.data['data']['accessToken'];
    await secureStorage.write(key: StorageKeys.accessToken, value: accessToken);
    _accessToken = accessToken;
  }

  Future<void> _loadUserFromStorage() async {
    final secureStorage = sl<FlutterSecureStorage>();
    final jsonUser = await secureStorage.read(key: StorageKeys.user);
    if (jsonUser != null) {
      final decodedUser = jsonDecode(jsonUser);
      _currentUser = UserModel.fromJson(decodedUser);
    }
  }

  Future<void> _loadTokensFromStorage() async {
    final secureStorage = sl<FlutterSecureStorage>();
    _accessToken = await secureStorage.read(key: StorageKeys.accessToken);
    _refreshToken = await secureStorage.read(key: StorageKeys.refreshToken);
  }

  Future<void> setUser(UserModel user) async {
    final secureStorage = sl<FlutterSecureStorage>();
    _accessToken = user.accessToken;
    _refreshToken = user.refreshToken;
    final jsonUser = jsonEncode(user);
    await secureStorage.write(key: StorageKeys.user, value: jsonUser);
    _currentUser = user;
  }

  Future<void> clearUser() async {
    final secureStorage = sl<FlutterSecureStorage>();
    _accessToken = null;
    _refreshToken = null;
    _currentUser = null;
    await secureStorage.deleteAll();
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    final secureStorage = sl<FlutterSecureStorage>();
    await secureStorage.write(key: StorageKeys.accessToken, value: accessToken);
    await secureStorage.write(
      key: StorageKeys.refreshToken,
      value: refreshToken,
    );
  }

  String? get currentUserId => _currentUser?.id;
  bool get isLoggedIn => _currentUser != null;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
}
