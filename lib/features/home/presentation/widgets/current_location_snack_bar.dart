import 'package:celluweather_task1/features/home/presentation/manager/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationButton extends StatelessWidget {
  final TextEditingController cityController;

  const CurrentLocationButton({super.key, required this.cityController});

  Future<Position?> _getCurrentLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showError(context, 'خدمة الموقع غير مفعلة');
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showError(context, 'تم رفض إذن الموقع');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showError(context, 'إذن الموقع مرفوض بشكل دائم، اذهب للإعدادات لتفعيله');
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(Icons.warning, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth < 400 ? 20.0 : 24.0;

    return IconButton(
      tooltip: 'Use current location',
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.my_location,
          color: Colors.blueAccent,
          size: iconSize,
        ),
      ),
      onPressed: () async {
        final position = await _getCurrentLocation(context);
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
                    Expanded(
                      child: Text(
                        'تم تحديد موقعك: $cityName',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
