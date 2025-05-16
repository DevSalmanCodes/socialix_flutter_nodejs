import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signUpUser(
    String username,
    String email,
    String password,
    String imagePath,
  );

  Future<UserEntity> loginUser(String email, String password);
  Future<void> logoutUser();

  Future<bool> isLoggedIn();
}
