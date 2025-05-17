import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/core/routing/router.dart';
import 'package:socialix_flutter_nodejs/core/theme/app_theme.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/usecases/login_user.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/usecases/logout_user.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/usecases/sign_up_user.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/cubits/auth_state_cubit.dart';
import 'package:socialix_flutter_nodejs/injection/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  final AuthRepositoryImpl authRepositoryImpl = sl<AuthRepositoryImpl>();
  runApp(
    MyApp(
      signUpUser: SignUpUser(authRepository: authRepositoryImpl),
      loginUser: LoginUser(authRepository: authRepositoryImpl),
      logoutUser: LogoutUser(authRepository: authRepositoryImpl),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SignUpUser signUpUser;
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  const MyApp({
    super.key,
    required this.signUpUser,
    required this.loginUser,
    required this.logoutUser,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => AuthBloc(
                signUpUser: signUpUser,
                loginUser: loginUser,
                logoutUser: logoutUser,
              ),
        ),
        BlocProvider(
          create:
              (context) =>
                  AuthStateCubit(authRepository: sl<AuthRepositoryImpl>()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.dark,
        theme: AppThemes.lightTheme,
        routerConfig: router,
      ),
    );
  }
}
