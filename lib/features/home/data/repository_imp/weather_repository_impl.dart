// Step 6: Repository Implementation
import 'package:celluweather_task1/features/home/data/datasource/weather_remote_data_source.dart';
import 'package:celluweather_task1/features/home/domain/entities/weather_entity.dart';
import 'package:celluweather_task1/features/home/domain/repository/weather_repository.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastRemoteDataSource remoteDataSource;

  ForecastRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ForecastDayEntity>> getForecast(String city) {
    return remoteDataSource.fetchForecast(city);
  }
}
