import 'package:diary_toy_project/layers/domain/coding_key.dart';
import 'package:diary_toy_project/layers/domain/notification_preferences.dart';

class Settings {
  Settings({this.theme, this.notificationPreferences, this.privacyLevel});

  String? theme;

  @CodingKey('notification_preferences')
  NotificationPreferences? notificationPreferences;

  @CodingKey('privacy_level')
  String? privacyLevel;
}
