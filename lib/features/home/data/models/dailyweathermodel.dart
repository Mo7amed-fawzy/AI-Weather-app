import 'package:celluweather_task1/features/home/domain/entities/daily_weather_entity.dart';

class DailyWeatherModel extends DailyWeatherEntity {
  DailyWeatherModel({
    required super.date,
    required super.maxTempC,
    required super.minTempC,
    required super.conditionText,
    required super.conditionIcon,
    required super.dailyChanceOfRain,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    return DailyWeatherModel(
      date: json['date'],
      maxTempC: json['day']['maxtemp_c']?.toDouble() ?? 0.0,
      minTempC: json['day']['mintemp_c']?.toDouble() ?? 0.0,
      conditionText: json['day']['condition']['text'],
      conditionIcon: json['day']['condition']['icon'],
      dailyChanceOfRain: json['day']['daily_chance_of_rain'] ?? 0,
    );
  }
}
