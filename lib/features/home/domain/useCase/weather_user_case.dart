import 'package:celluweather_task1/features/home/domain/repository/weather_repository.dart';

import '../entities/weather_entity.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<WeatherEntity> call(String cityName) {
    return repository.fetchWeather(cityName);
  }
}
