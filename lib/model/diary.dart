import 'dart:convert';

import 'package:diary_toy_project/application/utils/date_formatter.dart';

import '../application/common/coding_key.dart';
import 'location.dart';

final class Diary {
  Diary({
    this.entryIdentifier,
    this.userIdentifier,
    this.title = "",
    this.content = "",
    this.mood,
    this.weather,
    this.isPublic,
    this.locationList,
    this.entryDate,
    this.postAt,
    DateTime? createdAt,
    this.updatedAt,
    this.tags,
    // this.mediaList,
  }) : createdAt = createdAt ?? DateTime.now();

  @CodingKey('entry_id')
  String? entryIdentifier;

  @CodingKey('user_id')
  String? userIdentifier;

  String title;

  String content;

  String? mood;

  String? weather;

  @CodingKey('is_public')
  bool? isPublic;

  @CodingKey('location')
  List<Location>? locationList;

  @CodingKey('entry_date')
  DateTime? entryDate;

  @CodingKey('post_at')
  DateTime? postAt;

  @CodingKey('created_at')
  DateTime createdAt;

  @CodingKey('updated_at')
  DateTime? updatedAt;

  List<String>? tags;

  @CodingKey('media')
  // List<Media>? mediaList;

  // MARK: - Mapping

  factory Diary.fromJson(String source) => Diary.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory Diary.fromMap(Map<String, dynamic> map) => Diary(
        entryIdentifier: map['entry_id'],
        userIdentifier: map['user_id'],
        title: map['title'],
        content: map['content'],
        mood: map['mood'],
        weather: map['weather'],
        isPublic: map['is_public'],
        locationList: List<Location>.from(
            map['location']?.map((dynamic x) => Location.fromMap(x)) ?? []),
        entryDate: map['entry_date'] != null
            ? DateTime.parse(map['entry_date'])
            : null,
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'])
            : null,
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(map['updated_at'])
            : null,
        tags: List<String>.from(
          map['tags'] ?? [],
        ),
        // mediaList: List<MediaDTO>.from(map['media']?.map((dynamic x) => MediaDTO.fromMap(x)) ?? []),
      );

  Map<String, dynamic> toMap() => {
        'entry_id': entryIdentifier,
        'user_id': userIdentifier,
        'title': title,
        'content': content,
        'mood': mood,
        'weather': weather,
        'is_public': isPublic,
        'location': locationList?.map((x) => x.toMap()).toList() ?? [],
        'entry_date': entryDate?.iso,
        'post_at': postAt?.iso,
        'created_at': createdAt.iso,
        'updated_at': updatedAt?.iso,
        'tags': tags ?? [],
        // 'media': mediaList?.map((x) => (x as Media).toMap()).toList() ?? [],
      };
}
