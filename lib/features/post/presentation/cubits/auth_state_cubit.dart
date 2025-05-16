import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/repositories/auth_repository.dart';

enum UserAuthState { authenticated, unauthenticated, checking }

class AuthStateCubit extends Cubit<UserAuthState> {
  final AuthRepository authRepository;
  AuthStateCubit({required this.authRepository})
    : super(UserAuthState.checking) {
    _checkAuthState();
  }
  Future<void> _checkAuthState() async {
    final res = await authRepository.isLoggedIn();
    if (res == true) {
      emit(UserAuthState.authenticated);
    } else {
      emit(UserAuthState.unauthenticated);
    }
  }
}
