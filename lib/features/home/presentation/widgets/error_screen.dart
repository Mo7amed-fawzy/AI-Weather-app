import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorScreen({required this.message, required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off,
              size: screenWidth * 0.25,
              color: theme.colorScheme.error.withOpacity(0.7),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                color: theme.colorScheme.onBackground,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text("حاول مرة أخرى"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                textStyle: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
