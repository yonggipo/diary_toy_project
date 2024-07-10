import 'dart:convert';

import 'package:diary_toy_project/layers/data/user/notification_preferences_dto.dart';
import 'package:diary_toy_project/layers/domain/user/settings.dart';

final class SettingsDTO extends Settings {
  SettingsDTO({
    super.theme,
    super.notificationPreferences,
    super.privacyLevel,
  });

  factory SettingsDTO.fromJson(String source) =>
      SettingsDTO.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory SettingsDTO.fromMap(Map<String, dynamic> json) => SettingsDTO(
        theme: json['theme'],
        notificationPreferences: json['notification_preferences'] == null
            ? null
            : NotificationPreferencesDTO.fromMap(json['notification_preferences']),
        privacyLevel: json['privacy_level'],
      );

  Map<String, dynamic> toMap() => {
        'theme': theme,
        'notification_preferences':
            (notificationPreferences as NotificationPreferencesDTO).toMap(),
        'privacy_level': privacyLevel
      };
}
