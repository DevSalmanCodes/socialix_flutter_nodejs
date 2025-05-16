import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/core/errors/failures.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/datasources/auth_secure_local_data_source.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthSecureLocalDataSource secureLocalDataSource;
  AuthRepositoryImpl({
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
    } on ServerException catch (e) {
      throw ServerFailure(message: e.message.toString());
    }
  }

  @override
  Future<UserEntity> loginUser(String email, String password) async {
    try {
      final user = await remoteDataSource.loginUser(email, password);
      await secureLocalDataSource.saveToken('accessToken', user.accessToken);
      await secureLocalDataSource.saveToken('refreshToken', user.refreshToken);
      return user;
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Unexpected error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await remoteDataSource.logoutUser();
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Unexpected error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await secureLocalDataSource.isLoggedIn();
  }
}
