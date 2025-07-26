class DailyWeatherEntity {
  final String date;
  final double maxTempC;
  final double minTempC;
  final String conditionText;
  final String conditionIcon;
  final int dailyChanceOfRain;

  DailyWeatherEntity({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.conditionText,
    required this.conditionIcon,
    required this.dailyChanceOfRain,
  });
}
