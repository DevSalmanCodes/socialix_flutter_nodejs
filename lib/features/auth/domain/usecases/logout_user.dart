import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/repositories/auth_repository.dart';

class LogoutUser {
  final AuthRepository authRepository;

  LogoutUser({required this.authRepository});

  Future<UserEntity> call() async => await authRepository.logoutUser();
}
