import 'dart:convert';
import 'package:celluweather_task1/core/utils/api_key.dart';
import 'package:celluweather_task1/features/home/data/datasource/weather_remote_datasource.dart';
import 'package:celluweather_task1/features/home/data/models/weathermodel.dart';
import 'package:http/http.dart' as http;

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  @override
  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse(
        '${ApiKeys.baseUrl}/forecast.json?q=$cityName&days=3&key=${ApiKeys.apiKey}',
      ),

      // Uri.parse('$_baseUrl/forecast.json?key=${ApiKeys.apiKey}&q=$city&days=3'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
