import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/datasources/auth_secure_local_data_source.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthSecureLocalDataSource secureLocalDataSource;
  final AuthService authService;
  AuthRepositoryImpl({
    required this.authService,
    required this.remoteDataSource,
    required this.secureLocalDataSource,
  });
  @override
  Future<UserEntity> signUpUser(
    String username,
    String email,
    String password,
    String imagePath,
  ) {
    try {
      return remoteDataSource.singUpUser(username, email, password, imagePath);
    } on DioException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  @override
  Future<UserEntity> loginUser(String email, String password) async {
    try {
      final user = await remoteDataSource.loginUser(email, password);
      Future.wait([
        secureLocalDataSource.saveToken('accessToken', user.accessToken!),
        secureLocalDataSource.saveToken('refreshToken', user.refreshToken!),
      ]);
      await authService.setUser(user);
      return user;
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Unexpected error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserEntity> logoutUser() async {
    try {
      final res = await remoteDataSource.logoutUser();

      _deleteAccessAndRefreshToken();
      return res;
    } on DioException catch (e) {
      _deleteAccessAndRefreshToken();
      throw ServerException(e.response?.data['message'] ?? 'Unexpected error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await secureLocalDataSource.isLoggedIn();
  }

  Future<void> _deleteAccessAndRefreshToken() async {
    Future.wait([
      secureLocalDataSource.deleteToken('accessToken'),
      secureLocalDataSource.deleteToken('refreshToken'),
    ]);
  }
}
