import 'package:celluweather_task1/features/home/presentation/manager/weather_cubit.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/ai_prediction_widget.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/build_current_section.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/build_daily_section.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/build_hourly_section.dart';
import 'package:celluweather_task1/features/home/presentation/widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget buildStateWidget(
  BuildContext context,
  WeatherState state,
  TextEditingController cityController,
) {
  if (state is WeatherInitial) {
    return const Center(
      key: ValueKey('initial'),
      child: Text('Search in the world '),
    );
  }

  if (state is WeatherLoading) {
    return Skeletonizer(
      key: const ValueKey('loading'),
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Container(
            height: 120,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  if (state is WeatherLoaded) {
    final weather = state.weather;
    return SingleChildScrollView(
      key: const ValueKey('loaded'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCurrentSection(context, weather),
          const SizedBox(height: 20),
          buildHourlySection(weather),
          const SizedBox(height: 20),
          buildDailySection(weather),
          const SizedBox(height: 20),
          AiPredictionWidget(),
        ],
      ),
    );
  }

  if (state is WeatherError) {
    return ErrorScreen(
      key: const ValueKey('error'),
      message: state.message,
      onRetry: () {
        final city = cityController.text.trim();
        if (city.isNotEmpty) {
          context.read<WeatherCubit>().fetchWeather(city);
        }
      },
    );
  }

  return const SizedBox(key: ValueKey('empty'));
}
