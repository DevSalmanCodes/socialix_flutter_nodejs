import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socialix_flutter_nodejs/core/utils/size_config.dart';
import 'package:socialix_flutter_nodejs/core/widgets/custom_button.dart';
import 'package:socialix_flutter_nodejs/core/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: height * 0.2),
              const Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.03),
              CustomTextField(
                label: 'Email',
                controller: TextEditingController(),
              ),
              SizedBox(height: height * 0.03),
              CustomTextField(
                label: 'Password',
                controller: TextEditingController(),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomButton(
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {},
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
          ),
        ),
      ),
    );
  }
}
