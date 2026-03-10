import 'package:flutter/material.dart';

Widget buildHeader({required BuildContext context, required bool isBack}) {
  final theme = Theme.of(context);
  final colors = theme.colorScheme;

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Stack(
          children: [

            if (isBack)
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "IPU One",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: colors.primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "STUDENT PORTAL",
                      style: theme.textTheme.labelMedium?.copyWith(
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}