import 'package:flutter/material.dart';
import 'package:socialix_flutter_nodejs/core/routing/router.dart';
import 'package:socialix_flutter_nodejs/core/theme/app_theme.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/screens/login_screen.dart';

late Size? mq;
void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.dark,
      theme: AppThemes.lightTheme,
     routerConfig: router,
    );
  }
}
