// splash_screen.dart
import 'package:celluweather_task1/core/navigation/go_router.dart';
import 'package:celluweather_task1/features/auth/data/datasources/local_storage_cubit.dart';
import 'package:celluweather_task1/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      final localStorageCubit = context.read<LocalStorageCubit>();
      final supabaseAuth = SupabaseAuthDatasource();

      final isLocalLoggedIn = localStorageCubit.state;
      final isSupabaseLoggedIn = supabaseAuth.isLoggedIn();

      if (isLocalLoggedIn || isSupabaseLoggedIn) {
        GoRouter.of(context).go('${NavigationRoutes.weatherScreen}/Cairo');
      } else {
        GoRouter.of(context).go(NavigationRoutes.signInScreen);
      }
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
