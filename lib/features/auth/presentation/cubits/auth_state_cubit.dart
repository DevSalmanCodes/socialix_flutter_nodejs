import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/repositories/auth_repository.dart';

enum UserAuthState { authenticated, unauthenticated, checking }

class AuthStateCubit extends Cubit<UserAuthState> {
  final IAuthRepository authRepository;
  AuthStateCubit({required this.authRepository})
    : super(UserAuthState.checking) {
    _checkAuthState();
  }
  Future<void> _checkAuthState() async {
    
  }
}
