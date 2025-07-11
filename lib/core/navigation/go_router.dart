import 'package:celluweather_task1/features/auth/presentation/screens/auth_screen.dart';
import 'package:celluweather_task1/features/auth/presentation/screens/login_page.dart';
import 'package:celluweather_task1/features/auth/presentation/screens/sign_in_page.dart';
import 'package:celluweather_task1/features/home/presentation/screens/home.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRoutes {
  static const String authScreen = '/';
  static const String signInScreen = '/signInScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String homeScreen = '/homeScreen';
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: NavigationRoutes.authScreen,
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.signInScreen,
      builder: (_, __) => SignInScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.signUpScreen,
      builder: (_, __) => SignUpScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.homeScreen,
      builder: (_, __) => HomeScreen(),
    ),
  ],
);
