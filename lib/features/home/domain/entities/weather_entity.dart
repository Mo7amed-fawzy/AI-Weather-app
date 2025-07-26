import 'package:celluweather_task1/features/home/domain/entities/current_weather_entity.dart';
import 'package:celluweather_task1/features/home/domain/entities/daily_weather_entity.dart';
import 'package:celluweather_task1/features/home/domain/entities/hourly_weather_entity.dart';
import 'package:celluweather_task1/features/home/domain/entities/location_entity.dart';

class WeatherEntity {
  final LocationEntity location;
  final CurrentWeatherEntity current;
  final List<HourlyWeatherEntity> hourly;
  final List<DailyWeatherEntity> daily;

  WeatherEntity({
    required this.location,
    required this.current,
    required this.hourly,
    required this.daily,
  });
}
