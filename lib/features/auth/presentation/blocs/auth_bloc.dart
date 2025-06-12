import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/usecases/login_user.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/usecases/logout_user.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/usecases/sign_up_user.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_event.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUser signUpUser;
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  AuthBloc({
    required this.signUpUser,
    required this.loginUser,
    required this.logoutUser,
  }) : super(AuthInitialState()) {
    on<LoginRequestEvent>(_onLoginRequested);
    on<SignUpRequestEvent>(_onSignUpRequested);
    on<LogoutRequestEvent>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequestEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final res = await loginUser(event.email, event.password);
    res.fold(
      (l) => emit(AuthErrorState(l.message)),
      (r) => emit(AuthSuccessState(r)),
    );
  }

  Future<void> _onSignUpRequested(
    SignUpRequestEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final res = await signUpUser(
      event.username,
      event.email,
      event.password,
      event.imagepath,
    );
    res.fold(
      (l) => emit(AuthErrorState(l.message)),
      (r) => emit(AuthSuccessState(r)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequestEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final res = await logoutUser();
    res.fold(
      (l) => emit(AuthErrorState(l.message)),
      (r) => AuthSuccessState(r),
    );
  }
}
