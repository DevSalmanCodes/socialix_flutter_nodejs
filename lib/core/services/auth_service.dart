import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/models/user_model.dart';
import 'package:socialix_flutter_nodejs/injection/service_locator.dart';

class AuthService {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<void> loadUserFromStorage() async {
    final secureStorage = sl<FlutterSecureStorage>();
    final jsonUser = await secureStorage.read(key: 'user');
    if (jsonUser != null) {
      final decodedUser = jsonDecode(jsonUser);
      _currentUser = UserModel.fromJson(decodedUser);
    }
  }

  Future<void> setUser(UserModel user) async {
    final secureStorage = sl<FlutterSecureStorage>();
    final jsonUser = jsonEncode(user);
    await secureStorage.write(key: 'user', value: jsonUser);
    _currentUser = user;
  }

  String? get currentUserId => _currentUser?.id;
  bool get isLoggedIn => _currentUser != null;
}
