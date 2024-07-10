import 'package:diary_toy_project/layers/domain/coding_key.dart';

class Location {
  Location({
    this.locationTime,
    this.latitude,
    this.longitude,
    this.placeName,
  });

  @CodingKey('location_time')
  DateTime? locationTime;

  double? latitude;

  double? longitude;

  @CodingKey('place_name')
  String? placeName;
}