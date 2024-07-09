import 'package:diary_toy_project/layers/domain/coding_key.dart';
import 'package:diary_toy_project/layers/domain/settings.dart';

class User {

  User({
    this.userIdentifier,
    this.username,
    this.role,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.settings,
    this.lastLogin,
    this.fcmToken,
  });

  @CodingKey('user_id')
  String? userIdentifier;

  String? username;

  String? role;

  String? email;

  @CodingKey('password_hash')
  String? password;

  @CodingKey('created_at')
  DateTime? createdAt;

  @CodingKey('updated_at')
  DateTime? updatedAt;

  Settings? settings;

  @CodingKey('last_login')
  DateTime? lastLogin;

  @CodingKey('fcm_token')
  String? fcmToken;
}
