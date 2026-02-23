import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/sign_in_view.dart';
import 'core/navigation/app_shell.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = true;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IPU One',
      theme: AppTheme.lightTheme(),
      home: isLoggedIn ? const AppShell() : const SignInView(),
    );
  }
}