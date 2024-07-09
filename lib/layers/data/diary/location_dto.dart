import 'dart:convert';

import 'package:diary_toy_project/layers/domain/diary/location.dart';

final class LocationDTO extends Location {
  LocationDTO({
    super.locationTime,
    super.latitude,
    super.longitude,
    super.placeName,
  });

  factory LocationDTO.fromJson(String source) =>
      LocationDTO.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory LocationDTO.fromMap(Map<String, dynamic> map) => LocationDTO(
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
