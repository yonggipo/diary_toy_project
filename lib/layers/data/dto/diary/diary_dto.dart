import 'dart:convert';

import 'package:diary_toy_project/layers/domain/diary/diary.dart';
import 'package:diary_toy_project/layers/data/dto/diary/location_dto.dart';
import 'package:diary_toy_project/layers/data/dto/diary/media_dto.dart';

final class DiaryDTO extends Diary {
  DiaryDTO({
    super.entryIdentifier,
    super.userIdentifier,
    super.title,
    super.content,
    super.mood,
    super.weather,
    super.isPublic,
    super.locationList,
    super.entryDate,
    super.createdAt,
    super.updatedAt,
    super.tags,
    super.mediaList,
  });

  String toJson() => json.encode(toMap());

  factory DiaryDTO.fromJson(String source) =>
      DiaryDTO.fromMap(json.decode(source));

  factory DiaryDTO.fromMap(Map<String, dynamic> map) => DiaryDTO(
        entryIdentifier: map['entry_id'],
        userIdentifier: map['user_id'],
        title: map['title'],
        content: map['content'],
        mood: map['mood'],
        weather: map['weather'],
        isPublic: map['is_public'],
        locationList: List<LocationDTO>.from(
            map['location']?.map((dynamic x) => LocationDTO.fromMap(x)) ?? []),
        entryDate: map['entry_date'] != null
            ? DateTime.parse(map['entry_date'])
            : null,
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'])
            : null,
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(map['updated_at'])
            : null,
        tags: List<String>.from(map['tags']?.map((dynamic x) => x)),
        mediaList: List<MediaDTO>.from(
            map['media']?.map((dynamic x) => MediaDTO.fromMap(x)) ?? []),
      );

  Map<String, dynamic> toMap() => {
        'entry_id': entryIdentifier,
        'user_id': userIdentifier,
        'title': title,
        'content': content,
        'mood': mood,
        'weather': weather,
        'is_public': isPublic,
        'location':
            locationList?.map((x) => (x as LocationDTO).toMap()).toList() ?? [],
        'entry_date': entryDate?.millisecondsSinceEpoch,
        'created_at': createdAt?.millisecondsSinceEpoch,
        'updated_at': updatedAt?.millisecondsSinceEpoch,
        'tags': tags,
        'media': mediaList?.map((x) => (x as MediaDTO).toMap()).toList() ?? [],
      };
}
