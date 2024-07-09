import 'dart:convert';

import 'package:diary_toy_project/layers/data/notification_preferences_dto.dart';
import 'package:diary_toy_project/layers/domain/settings.dart';

class SettingsDTO extends Settings {
  SettingsDTO({
    super.theme,
    super.notificationPreferences,
    super.privacyLevel,
  });

  factory SettingsDTO.fromJson(String str) =>
      SettingsDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SettingsDTO.fromMap(Map<String, dynamic> json) => SettingsDTO(
        theme: json['email'],
        notificationPreferences: json['notification_preferences'] == null
            ? null
            : NotificationPreferencesDTO.fromMap(json['location']),
        privacyLevel: json['privacy_level'],
      );

  Map<String, dynamic> toMap() => {
        'theme': theme,
        'notification_preferences':
            (notificationPreferences as NotificationPreferencesDTO).toMap(),
        'privacy_level': privacyLevel
      };
}
