import 'package:celluweather_task1/core/navigation/go_router.dart';
import 'package:celluweather_task1/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // context.read<LocalStorageCubit>().setLoggedIn(true);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundGradientEnd,
              AppColors.backgroundGradientStart,
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -200,
              child: Container(
                width: size.width * 1.5,
                height: size.width * 1.5,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              bottom: 100,
              left: 40,
              right: 40,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: customBorder(
                      backgroundC: AppColors.primaryBlue,
                      textC: AppColors.white,
                      label: "Sign In",
                      size: size,
                      onTap:
                          () => GoRouter.of(
                            context,
                          ).push(NavigationRoutes.signUpScreen),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: customBorder(
                      backgroundC: AppColors.white,
                      textC: AppColors.backgroundGradientStart,
                      size: size,
                      label: "Log In",
                      onTap:
                          () => GoRouter.of(
                            context,
                          ).push(NavigationRoutes.signInScreen),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

ElevatedButton customBorder({
  required Size size,
  VoidCallback? onTap,
  required String label,
  required Color backgroundC,
  required Color textC,
}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundC,
      foregroundColor: textC,
      minimumSize: Size(size.width * 0.8, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        // color: AppColors.primaryBlue,
      ),
    ),
  );
}
