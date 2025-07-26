import 'package:celluweather_task1/features/home/data/datasource/weather_remote_datasource.dart';
import 'package:celluweather_task1/features/home/domain/repository/weather_repository.dart';

import '../../domain/entities/weather_entity.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<WeatherEntity> fetchWeather(String cityName) async {
    final weatherModel = await remoteDataSource.getWeather(cityName);
    return weatherModel;
  }
}
