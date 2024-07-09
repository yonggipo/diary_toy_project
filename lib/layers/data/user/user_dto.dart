import 'dart:convert';

import 'package:diary_toy_project/layers/data/user/settings_dto.dart';
import 'package:diary_toy_project/layers/domain/user/user.dart';

final class UserDTO extends User {
  UserDTO({
    super.userIdentifier,
    super.username,
    super.role,
    super.email,
    super.password,
    super.createdAt,
    super.updatedAt,
    super.settings,
    super.lastLogin,
    super.fcmToken,
  });

  factory UserDTO.fromJson(String source) =>
      UserDTO.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory UserDTO.fromMap(Map<String, dynamic> map) => UserDTO(
        userIdentifier: map['user_id'],
        username: map['username'],
        role: map['role'],
        email: map['email'],
        password: map['password_hash'],
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'])
            : null,
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(map['updated_at'])
            : null,
        settings: map['settings'] != null
            ? SettingsDTO.fromMap(map['settings'])
            : null,
        lastLogin: map['last_login'] != null
            ? DateTime.parse(map['last_login'])
            : null,
        fcmToken: map['fcm_token'],
      );

  Map<String, dynamic> toMap() => {
        'user_id': userIdentifier,
        'username': username,
        'role': role,
        'email': email,
        'password_hash': password,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'settings': (settings as SettingsDTO).toMap(),
        'last_login': lastLogin?.toIso8601String(),
        'fcm_token': fcmToken,
      };
}
