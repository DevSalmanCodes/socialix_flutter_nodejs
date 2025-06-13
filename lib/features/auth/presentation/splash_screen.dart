import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';
import 'package:socialix_flutter_nodejs/injection/service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checkAuthStateAndNavigate();
    super.initState();
  }

  Future<void> _checkAuthStateAndNavigate() async {
    final authService = sl<AuthService>();
    final accessToken = authService.accessToken;
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      if (accessToken != null) {
        context.pushReplacement('/feed');
      } else {
        context.pushReplacement('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
