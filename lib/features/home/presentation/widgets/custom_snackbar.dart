import 'package:flutter/material.dart';

class CustomSnackbar {
  CustomSnackbar(BuildContext context, String s);

  static void show({
    BuildContext? context,
    String? message,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
  }) {
    final theme = Theme.of(context!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            backgroundColor ?? theme.colorScheme.primary.withValues(alpha: 0.9),
        elevation: 6,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            Icon(
              icon ?? Icons.location_on,
              color: textColor ?? theme.colorScheme.onPrimary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message!,
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
