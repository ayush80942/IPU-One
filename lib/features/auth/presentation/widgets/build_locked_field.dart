import 'package:flutter/material.dart';

Widget buildLockedField(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(letterSpacing: 1.2),
        ),
        const SizedBox(height: 8),
        TextField(
          enabled: false,
          controller: TextEditingController(text: value),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.badge_outlined),
            suffixIcon: Icon(Icons.lock),
          ),
        ),
        // const SizedBox(height: 6),
        // Text(
        //   "This ID is verified and locked to your device.",
        //   style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
        // ),
      ],
    );
  }