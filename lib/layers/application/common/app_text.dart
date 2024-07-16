final class AppText {
  static const String appName = 'SparkleDiary';
}

// MARK: - Diary List

extension DiaryListText on AppText {
  /// Tag: Nav Items
  static const String navTitle = '내 다이어리';

  /// Tag: Button
  static const String addNew = '작성하기';

  // Empty View Message
  static const String empty = '콘텐츠가 비어있습니다\n새로운 콘텐츠를 추가해주세요';
}

// MARK: - Diary Detail

extension DiaryDetailText on AppText {
  /// Tag: Nav Items
  static const String navTitle = '다이어리 작성하기';

  /// Tag: Button
  static const String save = '작성완료';

  /// Tag: TextField Placeholder
  static const String titlePlaceholder = '제목을 입력해주세요';
  static const String contentPlaceholder = '내용을 입력해주세요';
  static const String tagPlaceholder = '#콘서트 #뒷풀이';

  /// Tag: Label
  static const String weather = '날씨';
  static const String tag = '태그';
}

// MARK: - Tag

extension TagText on AppText {
  static const String concert = '콘서트';
  static const String afterParty = '뒷풀이';
  static const String giveAway = '현장나눔';
}

// MARK: - Weather

extension WeatherText on AppText {
  static const String cloud = '흐림';
  static const String sunny = '화창함';
  static const String rain = '비';
  static const String hot = '더움';
}
