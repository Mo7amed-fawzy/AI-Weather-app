import 'package:celluweather_task1/features/ai_analysis/data/datasources/ai_remote_datasource.dart';

class PredictTennisUseCase {
  final AiRemoteDataSource dataSource;

  PredictTennisUseCase(this.dataSource);

  Future<int> call(List<int> inputs) {
    return dataSource.predict(inputs);
  }
}
