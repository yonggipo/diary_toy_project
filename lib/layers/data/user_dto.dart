import 'dart:convert';

import 'package:diary_toy_project/layers/data/settings_dto.dart';
import 'package:diary_toy_project/layers/domain/user.dart';

class UserDTO extends User {

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

  factory UserDTO.fromJson(String source) => UserDTO.fromMap(json.decode(source) as Map<String, dynamic>);


  factory UserDTO.fromMap(Map<String, dynamic> map) {
    return UserDTO(
      userIdentifier: map['user_id'],
      username: map['username'],
      role: map['role'],
      email: map['email'],
      password: map['password'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      settings: map['settings'] != null ? SettingsDTO.fromMap(map['settings']) : null,
      lastLogin: map['lastLogin'] != null ? DateTime.parse(map['lastLogin']) : null,
      fcmToken: map['fcm_token'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userIdentifier': userIdentifier,
      'username': username,
      'role': role,
      'email': email,
      'password': password,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'settings': (settings as SettingsDTO).toMap(),
      'lastLogin': lastLogin?.toIso8601String(),
      'fcmToken': fcmToken,
    };
  }
  
  String toJson() => json.encode(toMap());
}