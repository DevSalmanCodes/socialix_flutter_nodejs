import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socialix_flutter_nodejs/core/routing/router.dart';
import 'package:socialix_flutter_nodejs/core/utils/size_config.dart';
import 'package:socialix_flutter_nodejs/core/widgets/custom_button.dart';
import 'package:socialix_flutter_nodejs/core/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.1),
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height * 0.03),

                CustomTextField(
                  label: 'Username',
                  controller: TextEditingController(),
                ),
                SizedBox(height: height * 0.02),

                CustomTextField(
                  label: 'Email',
                  controller: TextEditingController(),
                ),
                SizedBox(height: height * 0.02),

                CustomTextField(
                  label: 'Password',
                  controller: TextEditingController(),
                  obscureText: true,
                ),
                SizedBox(height: height * 0.02),

                CustomTextField(
                  label: 'Confirm Password',
                  controller: TextEditingController(),
                  obscureText: true,
                ),

                const SizedBox(height: 20),
                CustomButton(text: 'Sign Up', onTap: () {}),
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
            ),
          ),
        ),
      ),
    );
  }
}
