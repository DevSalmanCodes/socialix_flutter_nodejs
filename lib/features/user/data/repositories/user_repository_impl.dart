import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';
import 'package:socialix_flutter_nodejs/features/user/data/datasource/user_remote_data_source.dart';
import 'package:socialix_flutter_nodejs/features/user/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements IUserRepository {
  final IUserRemoteDataSource remoteDataSource;
  final AuthService authService;
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.authService,
  });
  @override
  Future<UserEntity> getCurrentUserDetails(String userId) async {
    try {
      return await remoteDataSource.getUserDetails(userId);
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Unexpected error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
