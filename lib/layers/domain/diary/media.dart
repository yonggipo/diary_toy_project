import '../../application/common/coding_key.dart';

class Media {
  Media({
    this.type,
    this.url,
    this.thumbnailURL,
    this.title,
    this.description,
    this.createdAt,
  });

  String? type; // "image", "video", "audio", "link"

  String? url;

  @CodingKey('thumbnail_url')
  String? thumbnailURL; // 비디오나 이미지의 경우

  String? title; // 링크의 경우

  String? description;

  @CodingKey('created_at')
  DateTime? createdAt;
}
