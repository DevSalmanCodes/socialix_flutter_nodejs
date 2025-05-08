abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final String message;
  AuthSuccessState({required this.message});
}

class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState({required this.error});
}
