import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
 final IAuthRepository authRepository;
  LoginUser({required this.authRepository});

  Future<UserEntity> call(String email, String password) async =>
      await authRepository.loginUser(email, password);
}
