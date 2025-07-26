import 'package:celluweather_task1/features/home/domain/entities/current_weather_entity.dart';

class CurrentWeatherModel extends CurrentWeatherEntity {
  CurrentWeatherModel({
    required super.tempC,
    required super.conditionText,
    required super.conditionIcon,
    required super.humidity,
    required super.windKph,
    required super.windDir,
    required super.uv,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      tempC: json['temp_c']?.toDouble() ?? 0.0,
      conditionText: json['condition']['text'],
      conditionIcon: json['condition']['icon'],
      humidity: json['humidity'],
      windKph: json['wind_kph']?.toDouble() ?? 0.0,
      windDir: json['wind_dir'],
      uv: json['uv']?.toDouble() ?? 0.0,
    );
  }
}
