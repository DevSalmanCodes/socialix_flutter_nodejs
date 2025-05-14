import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/core/routing/router.dart';
import 'package:socialix_flutter_nodejs/core/theme/app_theme.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/usecases/sign_up_user.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_bloc.dart';

late Size? mq;
void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AuthBloc(signUpUser: SignUpUser(authRepository: AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSource()))))
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
