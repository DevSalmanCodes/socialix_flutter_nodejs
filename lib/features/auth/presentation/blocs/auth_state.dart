import 'package:socialix_flutter_nodejs/features/user/domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserEntity data;
  AuthSuccessState( this.data);
}

class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState(this.error);
}
