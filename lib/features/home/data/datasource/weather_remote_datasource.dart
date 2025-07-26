import 'package:celluweather_task1/features/home/data/models/weathermodel.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather(String cityName);
}
