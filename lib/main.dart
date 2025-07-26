import 'package:celluweather_task1/core/navigation/go_router.dart';
import 'package:celluweather_task1/core/styles/app_theme.dart';
import 'package:celluweather_task1/core/utils/supabase_keys.dart';
import 'package:celluweather_task1/features/auth/data/datasources/local_storage_cubit.dart';
import 'package:celluweather_task1/features/auth/presentation/manager/auth_cubit.dart';
import 'package:celluweather_task1/features/home/presentation/manager/theme/theme_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/data/datasources/supabase_auth_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  client = http.Client();

  //  Supabase Initialization
  await Supabase.initialize(
    url: SupabaseKeys.projecturl,
    anonKey: SupabaseKeys.apinonKey,
  );

  //  HydratedBloc Initialization
  final directory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory(directory.path),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final supabaseAuthDatasource = SupabaseAuthDatasource();
  final GoRouter _router = router;
  // final dataSource = WeatherRemoteDataSourceImpl();
  // final repository = WeatherRepositoryImpl(dataSource);
  // final getWeatherUseCase = GetWeatherUseCase(repository);

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (_) => SupabaseAuthDatasource())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LocalStorageCubit()),

          BlocProvider(
            create:
                (context) => AuthCubit(
                  context.read<SupabaseAuthDatasource>(),
                  context.read<LocalStorageCubit>(),
                ),
          ),
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            final isDark = themeMode == ThemeMode.dark;
            final theme =
                isDark
                    ? AppTheme.darkNeoFuturisticTheme
                    : AppTheme.lightNeoFuturisticTheme;

            return AnimatedTheme(
              data: theme,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: MaterialApp.router(
                themeMode: themeMode,
                theme: AppTheme.lightNeoFuturisticTheme,
                darkTheme: AppTheme.darkNeoFuturisticTheme,
                debugShowCheckedModeBanner: false,
                routerConfig: _router,
              ),
            );
          },
        ),
      ),
    );
  }
}
