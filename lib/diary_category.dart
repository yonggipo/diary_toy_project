enum DiaryCategory {
  concert, // 콘서트
  afterParty, // 뒷풀이
  giveAway // 현장나눔
}

extension DiaryCategoryExt on DiaryCategory {
  String get title {
    switch (this) {
      case DiaryCategory.concert:
        return '콘서트';
      case DiaryCategory.afterParty:
        return '뒷풀이';
      case DiaryCategory.giveAway:
        return '현장나눔';
    }
  }
}
