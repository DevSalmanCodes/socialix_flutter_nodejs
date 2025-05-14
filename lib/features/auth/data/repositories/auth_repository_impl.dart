import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/core/errors/failures.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});
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
      print(e.toString());
      throw ServerFailure(message: e.message.toString());
    }
  }
}
