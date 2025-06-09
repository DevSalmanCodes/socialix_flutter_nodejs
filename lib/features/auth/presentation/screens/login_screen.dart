import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socialix_flutter_nodejs/core/utils/show_toast.dart';
import 'package:socialix_flutter_nodejs/core/utils/size_config.dart';
import 'package:socialix_flutter_nodejs/core/widgets/custom_button.dart';
import 'package:socialix_flutter_nodejs/core/widgets/custom_text_field.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_event.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessState) {
                showToast('Logged in successfully');
                context.pushReplacement('/feed');
              }
              if (state is AuthErrorState) {
                showToast(state.error);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: height * 0.2),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height * 0.03),
                  CustomTextField(label: 'Email', controller: _emailController),
                  SizedBox(height: height * 0.03),
                  CustomTextField(
                    label: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Login',

                    onTap: () {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        showToast('Email and password is required');
                      } else {
                        context.read<AuthBloc>().add(
                          LoginRequestEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      }
                    },
                    isLoading: state is AuthLoadingState,
                  ),
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () => context.push('/signup'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
