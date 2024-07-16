import 'package:get_it/get_it.dart';

import '../data/default_diary_repository.dart';
import '../data/source/network/api.dart';
import '../domain/repository/diary_repository.dart';
import '../domain/usecase/diary_usecase.dart';
import '../presentation/diary_list/controller/list_page_controller.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeGetIt() async {

  // MARK: - Data Layer

  getIt.registerLazySingleton<API>(() => DefaultAPI());
  // getIt.registerFactory<LocalStorage>(
  //   () => LocalStorageImpl(
  //     sharedPreferences: sharedPref,
  //   ),
  // );

  getIt.registerFactory<DiaryRepository>(
    () => DefaultDiaryRepository(
      api: getIt(),
    ),
  );

  // MARK: - Domain Layer

  getIt.registerFactory(
    () => DiaryUsecase(
      repository: getIt(),
    ),
  );

  // MARK: - Presentation Layer

  getIt.registerLazySingleton(
    () => ListPageController(diaryUsecase: getIt()),
  );
  // getIt.registerLazySingleton(
  //   () => CharacterDetailsController(),
  // );
}
