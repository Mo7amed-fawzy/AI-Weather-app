import 'package:celluweather_task1/features/home/domain/entities/weather_entity.dart';
import 'package:celluweather_task1/features/home/domain/useCase/weather_user_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final GetForecastUseCase useCase;

  ForecastCubit(this.useCase) : super(ForecastInitial());

  List<ForecastDayEntity> _forecast = [];
  int _selectedDayIndex = 0;

  void fetchForecast(String city) async {
    emit(ForecastLoading());
    try {
      final result = await useCase(city);
      _forecast = result;
      _selectedDayIndex = 0;
      emit(ForecastLoaded(_forecast, _selectedDayIndex));
    } catch (e) {
      emit(ForecastError(e.toString()));
    }
  }

  void selectDay(int index) {
    _selectedDayIndex = index;
    emit(ForecastLoaded(_forecast, _selectedDayIndex));
  }
}
