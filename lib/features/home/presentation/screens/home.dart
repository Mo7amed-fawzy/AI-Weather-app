import 'package:celluweather_task1/core/navigation/go_router.dart';
import 'package:celluweather_task1/features/ai_analysis/data/datasources/ai_remote_datasource.dart';
import 'package:celluweather_task1/features/ai_analysis/domain/usecases/predict_tennis_usecase.dart';
import 'package:celluweather_task1/features/ai_analysis/presentation/manager/ai_predict_cubit.dart';
import 'package:celluweather_task1/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:celluweather_task1/features/home/data/datasource/city_search_remote_datasource_impl.dart';
import 'package:celluweather_task1/features/home/presentation/manager/search/search_cubit.dart';
import 'package:celluweather_task1/features/home/presentation/manager/theme/theme_cubit.dart';
import 'package:celluweather_task1/features/home/presentation/manager/weather_cubit.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/animated_gradient_background.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/build_main_widget.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/custom_snackbar.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/get_current_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();
  final SupabaseAuthDatasource supabaseAuthDatasource =
      SupabaseAuthDatasource();

  WeatherPage({super.key});

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
                  IconButton(
                    icon: const Icon(Icons.my_location),
                    tooltip: 'Use current location',
                    onPressed: () async {
                      final position = await getCurrentLocation();
                      if (position != null) {
                        final coords =
                            '${position.latitude},${position.longitude}';
                        await context.read<WeatherCubit>().fetchWeather(coords);

                        final state = context.read<WeatherCubit>().state;
                        if (state is WeatherLoaded) {
                          cityController.text = state.weather.location.name;
                          CustomSnackbar.show(
                            context: context,
                            message:
                                'Location set to ${state.weather.location.name}',
                          );
                        } else {
                          CustomSnackbar.show(
                            context: context,
                            message: 'Failed to get location',
                          );
                        }
                      } else {
                        CustomSnackbar.show(
                          context: context,
                          message: 'Location unavailable',
                          backgroundColor: Colors.redAccent,
                          icon: Icons.warning,
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
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        buildSearchSection(context, cityController),
                        const SizedBox(height: 16),
                        Expanded(
                          child: BlocBuilder<WeatherCubit, WeatherState>(
                            builder: (context, state) {
                              return RefreshIndicator(
                                onRefresh: () async {
                                  final city = cityController.text.trim();
                                  if (city.isNotEmpty) {
                                    await context
                                        .read<WeatherCubit>()
                                        .fetchWeather(city);
                                  }
                                },
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
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
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildSearchSection(
  BuildContext context,
  TextEditingController controller,
) {
  return BlocBuilder<CitySearchCubit, List<String>>(
    builder: (context, citySuggestions) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: controller,
            onChanged: (value) {
              context.read<CitySearchCubit>().search(value);
            },
            decoration: InputDecoration(
              hintText: 'Enter city name',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  final city = controller.text.trim();
                  if (city.isNotEmpty) {
                    context.read<WeatherCubit>().fetchWeather(city);
                    context.read<CitySearchCubit>().clearSuggestions();
                  }
                },
              ),
            ),
          ),
          if (citySuggestions.isNotEmpty)
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: citySuggestions.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final suggestion = citySuggestions[index];
                  return ListTile(
                    title: Text(suggestion),
                    onTap: () {
                      controller.text = suggestion;
                      context.read<WeatherCubit>().fetchWeather(suggestion);
                      context.read<CitySearchCubit>().clearSuggestions();
                    },
                  );
                },
              ),
            ),
        ],
      );
    },
  );
}
