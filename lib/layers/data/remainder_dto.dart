// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:diary_toy_project/layers/domain/remainder.dart';

class RemainderDTO extends Remainder {
  RemainderDTO({
    super.reminderIdentifer,
    super.userIdentifier,
    super.reminderText,
    super.reminderDate,
    super.isCompleted,
    super.pirority,
    super.repeatType,
    super.createdAt,
    super.updatedAt,
  });

  factory RemainderDTO.fromJson(String source) =>
      RemainderDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'reminder_id': reminderIdentifer,
        'user_id': userIdentifier,
        'reminder_text': reminderText,
        'reminder_date': reminderDate?.toIso8601String(),
        'is_completed': isCompleted,
        'pirority': pirority,
        'repeat_type': repeatType,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  factory RemainderDTO.fromMap(Map<String, dynamic> map) => RemainderDTO(
        reminderIdentifer: map['reminder_id'],
        userIdentifier: map['user_id'],
        reminderText: map['reminder_text'],
        reminderDate: map['reminder_date'] != null
            ? DateTime.parse(map['reminder_date'])
            : null,
        isCompleted: map['is_completed'],
        pirority: map['pirority'],
        repeatType: map['repeat_type'],
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'])
            : null,
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(map['updated_at'])
            : null,
      );
}
