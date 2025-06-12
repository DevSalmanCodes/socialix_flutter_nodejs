import 'package:fpdart/fpdart.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/core/errors/failures.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
  final IAuthRepository authRepository;
  LoginUser({required this.authRepository});

  Future<Either<Failure, UserEntity>> call(
    String email,
    String password,
  ) async {
    try {
      final res = await authRepository.loginUser(email, password);
      return right(res);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
