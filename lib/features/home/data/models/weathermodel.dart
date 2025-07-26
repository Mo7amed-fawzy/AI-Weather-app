import 'package:celluweather_task1/features/home/data/models/currentweathermodel.dart';
import 'package:celluweather_task1/features/home/data/models/dailyweathermodel.dart';
import 'package:celluweather_task1/features/home/data/models/hourlyweathermodel.dart';
import 'package:celluweather_task1/features/home/data/models/locationemodel.dart';
import 'package:celluweather_task1/features/home/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.location,
    required super.current,
    required super.hourly,
    required super.daily,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final forecastDay = json['forecast']['forecastday'][0];
    final hourlyData = forecastDay['hour'] as List;
    final dailyData = json['forecast']['forecastday'] as List;

    return WeatherModel(
      location: LocationModel.fromJson(json['location']),
      current: CurrentWeatherModel.fromJson(json['current']),
      hourly: hourlyData.map((e) => HourlyWeatherModel.fromJson(e)).toList(),
      daily: dailyData.map((e) => DailyWeatherModel.fromJson(e)).toList(),
    );
  }
}
