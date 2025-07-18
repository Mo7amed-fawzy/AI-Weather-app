import 'package:celluweather_task1/features/auth/presentation/screens/login_page.dart';
import 'package:celluweather_task1/features/auth/presentation/screens/sign_in_page.dart';
import 'package:celluweather_task1/features/auth/presentation/screens/splash.dart';
import 'package:celluweather_task1/features/home/data/datasource/weather_remote_data_source.dart';
import 'package:celluweather_task1/features/home/data/repository_imp/weather_repository_impl.dart';
import 'package:celluweather_task1/features/home/domain/useCase/weather_user_case.dart';
import 'package:celluweather_task1/features/home/presentation/manager/weather_cubit.dart';
import 'package:celluweather_task1/features/home/presentation/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

abstract class NavigationRoutes {
  static const String splash = '/';
  static const String signInScreen = '/signInScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String weatherScreen =
      '/weatherScreen'; // will be used with /:city
}

late final http.Client client;

final forecastRepo = ForecastRepositoryImpl(ForecastRemoteDataSource(client));
final router = GoRouter(
  routes: [
    GoRoute(
      path: NavigationRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.signInScreen,
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: NavigationRoutes.signUpScreen,
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '${NavigationRoutes.weatherScreen}/:city',
      builder: (context, state) {
        final city = state.pathParameters['city']!;

        return BlocProvider(
          create: (_) => ForecastCubit(GetForecastUseCase(forecastRepo)),
          child: ForecastScreen(city: city),
        );
      },
    ),
  ],
);
