import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socialix_flutter_nodejs/core/routing/router.dart';
import 'package:socialix_flutter_nodejs/core/theme/app_theme.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/datasources/auth_secure_local_data_source.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/usecases/login_user.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/usecases/sign_up_user.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/cubits/auth_state_cubit.dart';
import 'package:socialix_flutter_nodejs/injection/service_locator.dart';

void main() async {
  initDependencies();
  final AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl(
    remoteDataSource: sl<AuthRemoteDataSource>(),
    secureLocalDataSource: sl<AuthSecureLocalDataSourceImpl>(),
  );
  runApp(
    MyApp(
      signUpUser: SignUpUser(authRepository: authRepositoryImpl),
      loginUser: LoginUser(authRepository: authRepositoryImpl),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SignUpUser signUpUser;
  final LoginUser loginUser;
  const MyApp({super.key, required this.signUpUser, required this.loginUser});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  AuthBloc(signUpUser: signUpUser, loginUser: loginUser),
        ),
        BlocProvider(
          create:
              (context) => AuthStateCubit(
                authRepository: AuthRepositoryImpl(
                  remoteDataSource: AuthRemoteDataSource(),
                  secureLocalDataSource: AuthSecureLocalDataSourceImpl(
                    secureStorage: FlutterSecureStorage(),
                  ),
                ),
              ),
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
