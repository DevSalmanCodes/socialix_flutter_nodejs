import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource remoteDataSource;
  final AuthService authService;
  AuthRepositoryImpl({
    required this.authService,
    required this.remoteDataSource,
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
      final res = await remoteDataSource.logoutUser(
        authService.currentUser!.accessToken!,
      );

      return res;
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Unexpected error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
