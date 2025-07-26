import 'package:flutter/material.dart';

class CustomSnackbar {
  // Private constructor to prevent instantiation
  CustomSnackbar._();

  static void show({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            backgroundColor ?? theme.colorScheme.primary.withOpacity(0.9),
        elevation: 6,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: duration,
        content: Row(
          children: [
            Icon(
              icon ?? Icons.info,
              color: textColor ?? theme.colorScheme.onPrimary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor ?? theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
