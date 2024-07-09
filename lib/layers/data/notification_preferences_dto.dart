import 'dart:convert';

import 'package:diary_toy_project/layers/domain/notification_preferences.dart';

class NotificationPreferencesDTO extends NotificationPreferences {
  NotificationPreferencesDTO({
    super.email,
    super.push,
  });

  factory NotificationPreferencesDTO.fromJson(String str) =>
      NotificationPreferencesDTO.fromMap(json.decode(str));

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
