// Step 4: Create Model
import 'package:celluweather_task1/features/home/domain/entities/weather_entity.dart';

class ForecastDayModel extends ForecastDayEntity {
  ForecastDayModel({
    required super.date,
    required super.temp,
    required super.wind,
    required super.humidity,
  });

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    return ForecastDayModel(
      date: json['date'],
      temp: json['day']['avgtemp_c']?.toDouble() ?? 0.0,
      wind: json['day']['maxwind_kph']?.toDouble() ?? 0.0,
      humidity: json['day']['avghumidity']?.toInt() ?? 0,
    );
  }
}
