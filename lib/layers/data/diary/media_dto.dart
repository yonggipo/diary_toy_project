import 'dart:convert';

import 'package:diary_toy_project/layers/domain/diary/media.dart';

final class MediaDTO extends Media {
  MediaDTO({
    super.type,
    super.url,
    super.thumbnailURL,
    super.title,
    super.description,
    super.createdAt,
  });

  factory MediaDTO.fromJson(String source) =>
      MediaDTO.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory MediaDTO.fromMap(Map<String, dynamic> map) => MediaDTO(
        type: map['type'],
        url: map['url'],
        thumbnailURL: map['thumbnailURL'],
        title: map['title'],
        description: map['description'],
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'])
            : null,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'type': type,
        'url': url,
        'thumbnail_url': thumbnailURL,
        'title': title,
        'description': description,
        'created_at': createdAt?.toIso8601String(),
      };
}
