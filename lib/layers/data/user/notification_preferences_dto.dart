import 'dart:convert';

import 'package:diary_toy_project/layers/domain/user/notification_preferences.dart';

final class NotificationPreferencesDTO extends NotificationPreferences {
  NotificationPreferencesDTO({
    super.email,
    super.push,
  });

  factory NotificationPreferencesDTO.fromJson(String source) =>
      NotificationPreferencesDTO.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory NotificationPreferencesDTO.fromMap(Map<String, dynamic> json) =>
      NotificationPreferencesDTO(
        email: json['email'],
        push: json['push'],
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'push': push,
      };
}
