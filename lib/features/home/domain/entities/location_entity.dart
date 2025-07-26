abstract class LocationEntity {
  final String name;
  final String region;
  final String country;
  final String localtime;

  const LocationEntity({
    required this.name,
    required this.region,
    required this.country,
    required this.localtime,
  });
}
