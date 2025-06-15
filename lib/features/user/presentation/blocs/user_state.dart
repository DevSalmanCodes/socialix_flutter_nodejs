import 'package:socialix_flutter_nodejs/features/user/domain/entities/user_entity.dart';

abstract class UserState {}

class UserInitialState extends UserState{}
class UserLoadingState extends UserState{}
class UserSuccessState extends UserState{
  final UserEntity userEntity;

  UserSuccessState(this.userEntity);
  
}
class UserErrorState extends UserState{
  final String message;

  UserErrorState(this.message);
}