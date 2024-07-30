import 'dart:convert';

import '../application/common/coding_key.dart';

class Location {
  Location({
    required this.placeName,
    required this.address,
    required this.x,
    required this.y,
  });

  @CodingKey('place_name')
  String placeName;

  String address;

  double x;

  double y;

  // MARK: - Mapping

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> map) => Location(
        placeName: map['placeName'] ?? "",
        address: map['address'] ?? "",
        x: map['x'] ?? 0,
        y: map['y'] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        'place_name': placeName,
        'address': address,
        'x': x,
        'y': y,
      };
}
