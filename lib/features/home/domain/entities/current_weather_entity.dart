class CurrentWeatherEntity {
  final double tempC;
  final String conditionText;
  final String conditionIcon;
  final int humidity;
  final double windKph;
  final String windDir;
  final double uv;

  CurrentWeatherEntity({
    required this.tempC,
    required this.conditionText,
    required this.conditionIcon,
    required this.humidity,
    required this.windKph,
    required this.windDir,
    required this.uv,
  });
}
