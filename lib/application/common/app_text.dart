final class AppText {
  static const String appName = 'SparkleDiary';

  /// Tag: Nav Items
  static const String diaryDetails = '다이어리 작성하기';

  /// Tag: Button
  static const String saveDiary = '작성완료';
  static const String searchAdress = '관련 장소 검색';

  /// Tag: TextField
  static const String title = '제목';
  static const String titleHint = '제목을 입력해주세요';
  static const String content = '내용';
  static const String contentHint = '내용을 입력해주세요';
  static const String tagHint = '# , \\" \\" 을 사용하여 구분해주세요';

  /// Tag: Example
  static const String tagExample = '#콘서트 #뒷풀이';

  /// Tag: Label
  static const String weather = '날씨';
  static const String tag = '태그';
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

extension DiaryDetailsText on AppText {}

// MARK: - Tag

extension TagText on AppText {
  static const String concert = '콘서트';
  static const String afterParty = '뒷풀이';
  static const String giveAway = '현장나눔';
}

// MARK: - Weather

extension WeatherText on AppText {
  static const String cloudy = '흐림';
  static const String sunny = '화창함';
  static const String rain = '비';
  static const String snow = '눈';
  static const String hot = '더움';
}
