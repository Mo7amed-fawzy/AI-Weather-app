class HourlyWeatherEntity {
  final String time;
  final double tempC;
  final String conditionText;
  final String conditionIcon;
  final int chanceOfRain;

  HourlyWeatherEntity({
    required this.time,
    required this.tempC,
    required this.conditionText,
    required this.conditionIcon,
    required this.chanceOfRain,
  });
}
