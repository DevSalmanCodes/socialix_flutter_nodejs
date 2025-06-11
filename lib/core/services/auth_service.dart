import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socialix_flutter_nodejs/core/constants/storage_keys.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/models/user_model.dart';
import 'package:socialix_flutter_nodejs/injection/service_locator.dart';

class AuthService {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<void> loadUserFromStorage() async {
    final secureStorage = sl<FlutterSecureStorage>();
    final jsonUser = await secureStorage.read(key: StorageKeys.user);
    if (jsonUser != null) {
      final decodedUser = jsonDecode(jsonUser);
      _currentUser = UserModel.fromJson(decodedUser);
    }
  }

  Future<void> setUser(UserModel user) async {
    final secureStorage = sl<FlutterSecureStorage>();
    final jsonUser = jsonEncode(user);
    await secureStorage.write(key: StorageKeys.user, value: jsonUser);
    _currentUser = user;
  }

  Future<void> clearUser() async {
    final secureStorage = sl<FlutterSecureStorage>();
    await secureStorage.delete(key: StorageKeys.user);
  }

  String? get currentUserId => _currentUser?.id;
  bool get isLoggedIn => _currentUser != null;
}
