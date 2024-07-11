import 'package:diary_toy_project/app_text.dart';

enum DiaryCategory {
  concert, // 콘서트
  afterParty, // 뒷풀이
  giveAway // 현장나눔
}

extension DiaryCategoryExt on DiaryCategory {
  String get title {
    switch (this) {
      case DiaryCategory.concert:
        return AppText.concert;
      case DiaryCategory.afterParty:
        return AppText.afterParty;
      case DiaryCategory.giveAway:
        return AppText.giveAway;
    }
  }
}
