import '../entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> fetchWeather(String cityName);
}
