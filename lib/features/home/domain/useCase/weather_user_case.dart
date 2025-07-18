// Step 3: Define Use Case
import 'package:celluweather_task1/features/home/domain/entities/weather_entity.dart';
import 'package:celluweather_task1/features/home/domain/repository/weather_repository.dart';

class GetForecastUseCase {
  final ForecastRepository repository;

  GetForecastUseCase(this.repository);

  Future<List<ForecastDayEntity>> call(String city) {
    return repository.getForecast(city);
  }
}
