import 'package:celluweather_task1/features/home/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.name,
    required super.region,
    required super.country,
    required super.localtime,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      localtime: json['localtime'],
    );
  }
}
