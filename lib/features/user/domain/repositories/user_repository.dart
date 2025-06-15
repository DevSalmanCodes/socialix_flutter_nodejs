import 'package:socialix_flutter_nodejs/features/user/domain/entities/user_entity.dart';

abstract class IUserRepository{
  Future<UserEntity> getCurrentUserDetails(String userId);
}