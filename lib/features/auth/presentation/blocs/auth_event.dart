abstract class AuthEvent {}

class LoginRequestEvent extends AuthEvent {
  final String email;
  final String password;

  LoginRequestEvent({required this.email, required this.password});
}

class 
SignUpRequestEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;
  String imagepath;


  SignUpRequestEvent({
    required this.username,
    required this.email,
    required this.password,
    required this.imagepath
  });
}

class LogoutRequestEvent extends AuthEvent {}
