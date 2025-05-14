import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserEntity data;
  AuthSuccessState({required this.data});
}

class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState({required this.error});
}
