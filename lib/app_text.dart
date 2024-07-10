final class AppText {
  static const String appName = 'SparkleDiary';

  // Nav Items
  static const String diaryMainNavTitle = '내 다이어리';
  static const String diaryDetailNavTitle = '내 다이어리';

  // Tab Bar Item
  static const String firstTabBarItemTitle = '콘서트';
  static const String secondTabBarItemTitle = '뒷풀이';
  static const String thirdTabBarItemTitle = '현장나눔';

  // Button Title
  static const String writeDiray = '작성하기';
  static const String saveDiray = '작성완료';

  // TextField Placeholder
  static const String diaryTitleTFPH = '작성하기';
  static const String diaryContentTFPH = '작성하기';

  // Empty View Message
  static const String emptyContentMessage = '콘텐츠가 비어있습니다\n새로운 콘텐츠를 추가해주세요';

  static const Weather weather = Weather();
}

// Weather Text
final class Weather {
  const Weather();

  static const String cloud = '흐림';
  static const String sunny = '화창함';
  static const String rain = '비';
  static const String hot = '더움';
}
