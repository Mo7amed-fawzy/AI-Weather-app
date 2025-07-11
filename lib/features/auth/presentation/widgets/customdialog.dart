import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:celluweather_task1/core/styles/colors.dart';

void showCustomDialog(BuildContext context, VoidCallback onConfirm) {
  final screenWidth = MediaQuery.of(context).size.width;

  showGeneralDialog(
    context: context,
    barrierLabel: "Are You Sure?",
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Opacity(
          opacity: anim1.value,
          child: Center(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  width: screenWidth * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: screenWidth * 0.15,
                              left: 20,
                              right: 20,
                              bottom: 16,
                            ),
                            child: const Text(
                              'Are You Sure ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                height: 1.3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white.withOpacity(
                                      0.1,
                                    ),
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(25),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                  child: const Text('Cancel'),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close dialog
                                    onConfirm(); // Execute signup
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white,
                                    foregroundColor: AppColors.primaryBlue,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(25),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                  child: const Text(
                                    'Confirm',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(6),
                  child: CircleAvatar(
                    radius: screenWidth * 0.08,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.check_box_rounded,
                      color: Colors.white,
                      size: screenWidth * 0.07,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
