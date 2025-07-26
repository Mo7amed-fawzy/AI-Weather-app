import 'package:celluweather_task1/features/home/presentation/manager/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationButton extends StatelessWidget {
  final TextEditingController cityController;

  const CurrentLocationButton({super.key, required this.cityController});

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Use current location',
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.my_location, color: Colors.blueAccent),
      ),
      onPressed: () async {
        final position = await _getCurrentLocation();
        if (position != null) {
          final coords = '${position.latitude},${position.longitude}';
          await context.read<WeatherCubit>().fetchWeather(coords);

          final state = context.read<WeatherCubit>().state;
          if (state is WeatherLoaded) {
            final cityName = state.weather.location.name;
            cityController.text = cityName;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.blueAccent,
                behavior: SnackBarBehavior.floating,
                content: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      'تم تحديد موقعك: $cityName',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              content: Row(
                children: [
                  Icon(Icons.warning, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'تعذر الوصول إلى الموقع',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
