import 'package:celluweather_task1/features/home/domain/entities/weather_entity.dart';
import 'package:celluweather_task1/features/home/domain/useCase/weather_user_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;

  WeatherCubit(this.getWeatherUseCase) : super(WeatherInitial());

  Future<void> fetchWeather(String cityName) async {
    emit(WeatherLoading());
    try {
      final weather = await getWeatherUseCase(cityName);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
