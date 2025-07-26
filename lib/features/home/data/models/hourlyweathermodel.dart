import 'package:celluweather_task1/features/home/domain/entities/hourly_weather_entity.dart';

class HourlyWeatherModel extends HourlyWeatherEntity {
  HourlyWeatherModel({
    required super.time,
    required super.tempC,
    required super.conditionText,
    required super.conditionIcon,
    required super.chanceOfRain,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      time: json['time'],
      tempC: json['temp_c']?.toDouble() ?? 0.0,
      conditionText: json['condition']['text'],
      conditionIcon: json['condition']['icon'],
      chanceOfRain: json['chance_of_rain'] ?? 0,
    );
  }
}
