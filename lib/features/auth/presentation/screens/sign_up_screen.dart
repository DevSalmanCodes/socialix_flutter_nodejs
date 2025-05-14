import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:socialix_flutter_nodejs/core/utils/pick_image.dart';
import 'package:socialix_flutter_nodejs/core/utils/show_toast.dart';
import 'package:socialix_flutter_nodejs/core/utils/size_config.dart';
import 'package:socialix_flutter_nodejs/core/widgets/custom_button.dart';
import 'package:socialix_flutter_nodejs/core/widgets/custom_text_field.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_event.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  String _imagePath = '';

  Future<void> _onAvatarTapped() async {
    final pickedImagePath = await pickImage();
    if (pickedImagePath != null) {
      _imagePath = pickedImagePath;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthErrorState) {
                  Fluttertoast.showToast(msg: state.error.toString());
                }
                if (state is AuthSuccessState) {
                  showToast('Account created successfuly');
                  context.pushReplacement('/');
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(height: height * 0.1),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    GestureDetector(
                      onTap: _onAvatarTapped,
                      child: CircleAvatar(
                        backgroundImage:
                            _imagePath == ''
                                ? NetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                )
                                : FileImage(File(_imagePath)),
                        radius: 50,
                      ),
                    ),
                    SizedBox(height: height * 0.03),

                    CustomTextField(
                      label: 'Username',
                      controller: _usernameController,
                    ),
                    SizedBox(height: height * 0.02),

                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      label: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    SizedBox(height: height * 0.02),

                    CustomTextField(
                      label: 'Confirm Password',
                      controller: TextEditingController(),
                      obscureText: true,
                    ),

                    const SizedBox(height: 20),
                    CustomButton(
                      child:
                          state is! AuthLoadingState
                              ? Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                              : Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                      onTap:
                          () => context.read<AuthBloc>().add(
                            SignUpRequestEvent(
                              username: _usernameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              imagepath: _imagePath,
                            ),
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () => context.push('/'),
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
      ),
    );
  }
}
