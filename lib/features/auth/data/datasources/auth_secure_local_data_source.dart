import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthSecureLocalDataSource {
  Future<void> saveToken(String key, String token);
  Future<String?> getToken(String key);
  Future<void> deleteToken(String key);
  Future<bool> isLoggedIn();
}

class AuthSecureLocalDataSourceImpl extends AuthSecureLocalDataSource {
  FlutterSecureStorage secureStorage;
  AuthSecureLocalDataSourceImpl({required this.secureStorage});
  @override
  Future<void> saveToken(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> getToken(String key) async {
    return await secureStorage.read(key: key);
  }

  @override
  Future<void> deleteToken(String key) async {
    await secureStorage.delete(key: key);
  }
@override
  Future<bool> isLoggedIn() async {
    final res = await getToken('accessToken');
    return res != null && res.isNotEmpty;
  }
}
