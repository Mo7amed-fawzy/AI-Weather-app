import 'dart:convert';

import 'package:celluweather_task1/core/utils/api_key.dart';
import 'package:celluweather_task1/features/home/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

class ForecastRemoteDataSource {
  final String _baseUrl = 'http://api.weatherapi.com/v1';
  final http.Client client;

  ForecastRemoteDataSource(this.client);

  Future<List<ForecastDayModel>> fetchForecast(String city) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/forecast.json?key=${ApiKeys.apiKey}&q=$city&days=3'),
    );

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      final List<dynamic> daysJson = jsonMap['forecast']['forecastday'];
      return daysJson
          .map((dayJson) => ForecastDayModel.fromJson(dayJson))
          .toList();
    } else {
      throw Exception('Failed to fetch forecast data');
    }
  }
}
