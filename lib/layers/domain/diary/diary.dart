import '../../application/common/coding_key.dart';
import 'location.dart';
import 'media.dart';

class Diary {
  Diary({
    this.entryIdentifier,
    this.userIdentifier,
    this.title,
    this.content,
    this.mood,
    this.weather,
    this.isPublic,
    this.locationList,
    this.entryDate,
    this.createdAt,
    this.updatedAt,
    this.tags,
    this.mediaList,
  });

  @CodingKey('entry_id')
  String? entryIdentifier;

  @CodingKey('user_id')
  String? userIdentifier;

  String? title;

  String? content;

  String? mood;

  String? weather;

  @CodingKey('is_public')
  bool? isPublic;

  @CodingKey('location')
  List<Location>? locationList;

  @CodingKey('entry_date')
  DateTime? entryDate;

  @CodingKey('created_at')
  DateTime? createdAt;

  @CodingKey('updated_at')
  DateTime? updatedAt;

  List<String>? tags;

  @CodingKey('media')
  List<Media>? mediaList;
}
