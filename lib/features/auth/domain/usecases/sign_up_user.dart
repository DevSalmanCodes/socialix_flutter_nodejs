import 'package:fpdart/fpdart.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/core/errors/failures.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/repositories/auth_repository.dart';

class SignUpUser {
  final IAuthRepository authRepository;
  SignUpUser({required this.authRepository});
  Future<Either<Failure, UserEntity>> call(
    String username,
    String email,
    String password,
    String imagePath,
  ) async {
    try {
      final res = await authRepository.signUpUser(
        username,
        email,
        password,
        imagePath,
      );
      return right(res);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
