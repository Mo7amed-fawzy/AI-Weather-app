part of 'weather_cubit.dart';

abstract class ForecastState {}

class ForecastInitial extends ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastLoaded extends ForecastState {
  final List<ForecastDayEntity> forecast;
  final int selectedIndex;

  ForecastLoaded(this.forecast, this.selectedIndex);

  ForecastDayEntity get selectedDay => forecast[selectedIndex];
}

class ForecastError extends ForecastState {
  final String message;
  ForecastError(this.message);
}
