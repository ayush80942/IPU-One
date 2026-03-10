import 'package:flutter/material.dart';
import 'package:ipu_one/features/auth/presentation/pages/enroll_page.dart';
import 'package:ipu_one/features/auth/presentation/pages/otp_page.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/app_shell.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IPU One',
      theme: AppTheme.lightTheme(),
      home: isLoggedIn ? const AppShell() : const EnrollView(),
    );
  }
}