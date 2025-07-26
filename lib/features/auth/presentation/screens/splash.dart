import 'package:celluweather_task1/core/navigation/go_router.dart';
import 'package:celluweather_task1/features/auth/data/datasources/local_storage_cubit.dart';
import 'package:celluweather_task1/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      final localStorageCubit = context.read<LocalStorageCubit>();
      final supabaseAuth = SupabaseAuthDatasource();

      final isLocalLoggedIn = localStorageCubit.state;
      final isSupabaseLoggedIn = supabaseAuth.isLoggedIn();

      final route =
          (isLocalLoggedIn || isSupabaseLoggedIn)
              ? '${NavigationRoutes.weatherScreen}/Cairo'
              : NavigationRoutes.signInScreen;

      // استخدام fade transition عبر GoRouter أو أي navigator تفضله
      GoRouter.of(context).go(route);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: const Center(
            child: Icon(Icons.cloud, size: 100, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
