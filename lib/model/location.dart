import 'dart:convert';

import '../application/common/coding_key.dart';

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

  // MARK: - Mapping

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> map) => Location(
        locationTime: map['locationTime'] != null
            ? DateTime.parse(map['locationTime'])
            : null,
        latitude: map['latitude'],
        longitude: map['longitude'],
        placeName: map['placeName'],
      );

  Map<String, dynamic> toMap() => {
        'location_time': locationTime?.toIso8601String(),
        'latitude': latitude,
        'longitude': longitude,
        'place_name': placeName,
      };
}
