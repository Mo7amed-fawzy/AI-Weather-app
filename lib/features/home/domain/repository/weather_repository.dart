// Step 2: Define Repository Contract
import '../entities/weather_entity.dart';

abstract class ForecastRepository {
  Future<List<ForecastDayEntity>> getForecast(String city);
}
