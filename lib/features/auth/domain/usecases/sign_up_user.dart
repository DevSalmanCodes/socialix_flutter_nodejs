import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/repositories/auth_repository.dart';

class SignUpUser {
  final IAuthRepository authRepository;
  SignUpUser({required this.authRepository});
  Future<UserEntity> call(
    String username,
    String email,
    String password,
    String imagePath,
  ) async =>
      await authRepository.signUpUser(username, email, password, imagePath);
}
