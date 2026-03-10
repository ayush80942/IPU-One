import 'package:flutter/material.dart';
import 'package:ipu_one/features/home/presentation/home_view.dart';
import 'package:ipu_one/features/notices/presenation/notices_view.dart';
import 'package:ipu_one/features/profile/presentation/profile_view.dart';
import 'package:ipu_one/features/requests/presentation/requests_view.dart';
import 'package:ipu_one/features/documents/presentation/docs_view.dart';
import 'app_bottom_nav.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeView(),
    NoticesView(),
    RequestsView(),
    DocumentsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
      ),
    );
  }
}