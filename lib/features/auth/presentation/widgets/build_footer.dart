import 'package:flutter/material.dart';

Widget buildFooter({required BuildContext context}) {
  final theme = Theme.of(context);
  final colors = theme.colorScheme;

  return Column(
    children: [
      Text(
        "Need help with your account?",
        style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
      ),

      const SizedBox(height: 8),

      Text(
        "Contact Student Cell",
        style: TextStyle(
          color: colors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),

      const SizedBox(height: 24),
    ],
  );
}
