import 'package:celluweather_task1/core/navigation/go_router.dart';
import 'package:celluweather_task1/core/styles/colors.dart';
import 'package:celluweather_task1/core/styles/toast.dart';
import 'package:celluweather_task1/features/auth/data/datasources/local_storage_cubit.dart';
import 'package:celluweather_task1/features/auth/presentation/manager/auth_cubit.dart';
import 'package:celluweather_task1/features/auth/presentation/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final cubit = context.read<AuthCubit>();
    //  WeatherEntity weatherEntity = WeatherEntity();
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF001F3F), Color(0xFF002B64)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.08,
                vertical: 40,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoading) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder:
                              (_) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                        );
                      } else {
                        Navigator.of(context, rootNavigator: true).pop();
                      }

                      if (state is AuthSuccess) {
                        showToast(
                          text: "Logged in successfully",
                          state: ToastStates.success,
                        );

                        context.read<LocalStorageCubit>().setLoggedIn(true);
                        GoRouter.of(context).go(NavigationRoutes.weatherScreen);
                        // GoRouter.of(context).go(
                        //   NavigationRoutes.weatherScreen,
                        //   extra: weatherEntity,
                        // );
                      } else if (state is AuthFailure) {
                        showToast(
                          text: state.message,
                          state: ToastStates.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: size.width * 0.08,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "CREATE AN ACCOUNT TO MAKE SDFSDF",
                            style: TextStyle(
                              fontSize: size.width * 0.035,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),

                          buildTextField("Email", cubit.emailController, size),
                          const SizedBox(height: 20),
                          buildTextField(
                            "Password",
                            cubit.passwordController,
                            size,
                            isPassword: true,
                          ),
                          const SizedBox(height: 10),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Navigate to forgot password screen
                              },
                              child: Text(
                                "Forget your password?",
                                style: TextStyle(
                                  color: AppColors.blueButtonColor,
                                  fontSize: size.width * 0.035,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            child: customBorder(
                              backgroundC: AppColors.primaryBlue,
                              textC: AppColors.white,
                              size: size,
                              label: "LogIn",
                              onTap: () {
                                final email = cubit.emailController.text.trim();
                                final password =
                                    cubit.passwordController.text.trim();

                                if (email.isNotEmpty && password.isNotEmpty) {
                                  context.read<AuthCubit>().loginUser();
                                } else {
                                  showToast(
                                    text: "Please enter email and password",
                                    state: ToastStates.warning,
                                  );
                                }
                              },
                            ),
                          ),

                          const SizedBox(height: 20),

                          GestureDetector(
                            onTap:
                                () => GoRouter.of(context).pushReplacement(
                                  NavigationRoutes.signUpScreen,
                                ),
                            child: Text(
                              "DON'T HAVE AN ACCOUNT ?",
                              style: TextStyle(
                                color: AppColors.blueButtonColor,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.035,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget buildTextField(
  String label,
  TextEditingController controller,
  Size size, {
  bool isPassword = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: size.width * 0.035,
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.1),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ],
  );
}
