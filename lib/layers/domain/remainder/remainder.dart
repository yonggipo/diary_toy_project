import '../../application/common/coding_key.dart';

class Remainder {
  Remainder({
    this.reminderIdentifer,
    this.userIdentifier,
    this.reminderText,
    this.reminderDate,
    this.isCompleted,
    this.pirority,
    this.repeatType,
    this.createdAt,
    this.updatedAt,
  });
  
  @CodingKey('reminder_id')
  String? reminderIdentifer;

  @CodingKey('user_id')
  String? userIdentifier;

  @CodingKey('reminder_text')
  String? reminderText;

  @CodingKey('reminder_date')
  DateTime? reminderDate;

  @CodingKey('is_completed')
  bool? isCompleted;

  String? pirority;

  @CodingKey('repeat_type')
  String? repeatType; // e.g., "none", "daily", "weekly", "monthly"

  @CodingKey('created_at')
  DateTime? createdAt;

  @CodingKey('updated_at')
  DateTime? updatedAt;
}
