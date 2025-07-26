// features/home/data/datasource/city_search_remote_datasource.dart
abstract class CitySearchRemoteDataSource {
  Future<List<String>> searchCities(String query);
}
