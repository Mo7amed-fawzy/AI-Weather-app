// Step 1: Define Entity
class ForecastDayEntity {
  final String date;
  final double temp;
  final double wind;
  final int humidity;

  ForecastDayEntity({
    required this.date,
    required this.temp,
    required this.wind,
    required this.humidity,
  });
}
