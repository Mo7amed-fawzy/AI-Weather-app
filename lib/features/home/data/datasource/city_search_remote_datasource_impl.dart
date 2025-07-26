// features/home/data/datasource/city_search_remote_datasource_impl.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:celluweather_task1/core/utils/api_key.dart';
import 'city_search_remote_datasource.dart';

class CitySearchRemoteDataSourceImpl implements CitySearchRemoteDataSource {
  @override
  Future<List<String>> searchCities(String query) async {
    final response = await http.get(
      Uri.parse(
        '${ApiKeys.baseUrl}/search.json?key=${ApiKeys.apiKey}&q=$query',
      ),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map<String>((item) => item['name'].toString()).toList();
    } else {
      throw Exception('Failed to search cities');
    }
  }
}
