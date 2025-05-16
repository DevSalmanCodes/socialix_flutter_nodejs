import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/cubits/auth_state_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthStateCubit, UserAuthState>(
        listener: (context, state) {
          if (state == UserAuthState.authenticated) {
            context.pushReplacement('/feed');
          } else if (state == UserAuthState.unauthenticated) {
            context.pushReplacement('/login');
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [Center(child: CircularProgressIndicator())],
            ),
          );
        },
      ),
    );
  }
}
