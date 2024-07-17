import '../../application/common/coding_key.dart';
import 'notification_preferences.dart';

class Settings {
  Settings({this.theme, this.notificationPreferences, this.privacyLevel});

  String? theme;

  @CodingKey('notification_preferences')
  NotificationPreferences? notificationPreferences;

  @CodingKey('privacy_level')
  String? privacyLevel;
}
