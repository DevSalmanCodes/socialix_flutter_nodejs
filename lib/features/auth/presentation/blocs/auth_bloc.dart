import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_event.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<LoginRequestEvent>(_onLoginRequested);
    on<SignUpRequestEvent>(_onSignUpRequested);
    on<LogoutRequestEvent>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequestEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
    } catch (e) {
      emit(AuthErrorState(error: "Login Failed"));
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequestEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      // TODO: Add signup logic
    } catch (e) {
      emit(AuthErrorState(error: "Sign Up Failed"));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequestEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
    } catch (e) {
      emit(AuthErrorState(error: "Logout Failed"));
    }
  }
}
