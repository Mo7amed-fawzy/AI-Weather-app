import 'package:celluweather_task1/core/navigation/go_router.dart';
import 'package:celluweather_task1/features/ai_analysis/data/datasources/ai_remote_datasource.dart';
import 'package:celluweather_task1/features/ai_analysis/domain/usecases/predict_tennis_usecase.dart';
import 'package:celluweather_task1/features/ai_analysis/presentation/manager/ai_predict_cubit.dart';
import 'package:celluweather_task1/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:celluweather_task1/features/home/data/datasource/city_search_remote_datasource_impl.dart';
import 'package:celluweather_task1/features/home/presentation/manager/search/search_cubit.dart';
import 'package:celluweather_task1/features/home/presentation/manager/theme/theme_cubit.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/animated_gradient_background.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/build_main_widget.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/custom_snackbar.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/get_current_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'package:celluweather_task1/features/home/presentation/manager/weather_cubit.dart';

class WeatherPage extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();

  WeatherPage({super.key});

  final SupabaseAuthDatasource supabaseAuthDatasource =
      SupabaseAuthDatasource();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CitySearchCubit(CitySearchRemoteDataSourceImpl()),
        ),
        BlocProvider(
          create:
              (_) => AiPredictCubit(
                PredictTennisUseCase(AiRemoteDataSourceImpl(http.Client())),
              ),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return AnimatedGradientBackground(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Sign out',
                  onPressed: () async {
                    await supabaseAuthDatasource.signOut();
                    context.go(NavigationRoutes.signInScreen);
                  },
                ),
                title: const Text('VoidAI'),
                actions: [
                  // CurrentLocationButton(cityController: cityController),
                  IconButton(
                    icon: const Icon(Icons.my_location),
                    tooltip: 'Use current location',
                    onPressed: () async {
                      final position = await getCurrentLocation();
                      if (position != null) {
                        final coords =
                            '${position.latitude},${position.longitude}';

                        // استدعاء الطقس
                        await context.read<WeatherCubit>().fetchWeather(coords);

                        // جلب اسم المدينة بعد التحميل
                        final state = context.read<WeatherCubit>().state;
                        if (state is WeatherLoaded) {
                          cityController.text = state.weather.location.name;
                          CustomSnackbar(
                            context,
                            'Location set to ${state.weather.location.name}',
                            // icon: Icons.check_circle,
                          );
                        } else {
                          CustomSnackbar(context, 'Failed to get location');
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Location unavailable')),
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      themeMode == ThemeMode.light
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                    onPressed: () {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    BlocBuilder<CitySearchCubit, List<String>>(
                      builder: (context, citySuggestions) {
                        return Column(
                          children: [
                            TextField(
                              controller: cityController,
                              onChanged: (value) {
                                context.read<CitySearchCubit>().search(value);
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter city name',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    final city = cityController.text.trim();
                                    if (city.isNotEmpty) {
                                      context.read<WeatherCubit>().fetchWeather(
                                        city,
                                      );
                                      context
                                          .read<CitySearchCubit>()
                                          .clearSuggestions();
                                    }
                                  },
                                ),
                              ),
                            ),
                            if (citySuggestions.isNotEmpty)
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 6,
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                    ),
                                  ],
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: citySuggestions.length,
                                  itemBuilder: (context, index) {
                                    final suggestion = citySuggestions[index];
                                    return ListTile(
                                      title: Text(suggestion),
                                      onTap: () {
                                        cityController.text = suggestion;
                                        context
                                            .read<WeatherCubit>()
                                            .fetchWeather(suggestion);
                                        context
                                            .read<CitySearchCubit>()
                                            .clearSuggestions();
                                      },
                                    );
                                  },
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Weather Display with Pull to Refresh
                    Expanded(
                      child: BlocBuilder<WeatherCubit, WeatherState>(
                        builder: (context, state) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              final city = cityController.text.trim();
                              if (city.isNotEmpty) {
                                await context.read<WeatherCubit>().fetchWeather(
                                  city,
                                );
                              }
                            },

                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              switchInCurve: Curves.easeIn,
                              switchOutCurve: Curves.easeOut,
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },

                              child: buildStateWidget(
                                context,
                                state,
                                cityController,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
