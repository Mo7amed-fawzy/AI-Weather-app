import 'package:celluweather_task1/core/navigation/go_router.dart';
import 'package:celluweather_task1/core/styles/colors.dart';
import 'package:celluweather_task1/core/styles/toast.dart';
import 'package:celluweather_task1/features/auth/presentation/manager/auth_cubit.dart';
import 'package:celluweather_task1/features/auth/presentation/widgets/customdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = context.read<AuthCubit>();

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
                          text: "Account created successfully",
                          state: ToastStates.success,
                        );
                        GoRouter.of(context).go(NavigationRoutes.signInScreen);
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
                            "SIGN UP",
                            style: TextStyle(
                              fontSize: size.width * 0.07,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "CREATE AN ACCOUNT TO MAKE SDFSDF",
                            style: TextStyle(
                              fontSize: size.width * 0.032,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                          buildTextField("FULL NAME", cubit.fullNameController),
                          const SizedBox(height: 20),
                          buildTextField("Email", cubit.emailController),
                          const SizedBox(height: 20),
                          buildTextField(
                            "Password",
                            cubit.passwordController,
                            isPassword: true,
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Dot(isActive: true),
                              Dot(isActive: false),
                              Dot(isActive: false),
                            ],
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (cubit.emailController.text.isEmpty ||
                                    cubit.passwordController.text.isEmpty) {
                                  showToast(
                                    text: "Please enter email and password",
                                    state: ToastStates.warning,
                                  );
                                } else {
                                  showCustomDialog(
                                    context,
                                    () => cubit.signUp(),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue,
                                padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.018,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.04,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap:
                                () => GoRouter.of(context).pushReplacement(
                                  NavigationRoutes.signInScreen,
                                ),
                            child: Text(
                              "HAVE AN ACCOUNT ?",
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
  TextEditingController controller, {
  bool isPassword = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
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

class Dot extends StatelessWidget {
  final bool isActive;
  const Dot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
      ),
    );
  }
}
