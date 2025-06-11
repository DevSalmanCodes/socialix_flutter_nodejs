import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  Future<UserEntity> signUpUser(
    String username,
    String email,
    String password,
    String imagePath,
  );

  Future<UserEntity> loginUser(String email, String password);
  Future<UserEntity> logoutUser();

}
