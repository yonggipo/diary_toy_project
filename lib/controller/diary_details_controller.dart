import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../application/common/config/secrets.dart';
import '../application/utils/date_formatter.dart';
import '../model/diary.dart';
import '../model/weather.dart';

enum DetailsPageStatus { initial, loading, success, failed }

enum DetailsPageKind { add, update }

final class DiaryDetailsController extends GetxController {
  DiaryDetailsController({required this.diary, required this.kind});

  final dio = Dio();
  final Diary diary;
  final DetailsPageKind kind;

  updateTitle(String title) => diary.title = title;

  updateContent(String content) => diary.content = content;

  updateWeather(Weather weather) => diary.weather = weather.toCustomString();

  updateTags(List<String> tags) => diary.tags = tags;

  Future<Diary> detail({required String entryIdentifier}) async {
    try {
      final response =
          await dio.post('${Secrets.baseURL}diary/?entry_id=$entryIdentifier');
      return Diary.fromMap((response.data as dynamic));
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  // MAKR: - API

  Future<Diary> updateDiary() async {
    try {
      final response = await dio.put(
        '${Secrets.baseURL}diary/?entry_id=$diary.entryIdentifier',
        data: {
          "user_id": 'iVEsnXvKgQOXe8GxjozT',
          "entry_id": diary.entryIdentifier,
          "title": diary.title,
          "content": diary.content,
          "mood": "string",
          "weather": diary.weather,
          "post_at": DateTime.now().iso,
          "tags": diary.tags ?? []
        },
      );
      print('🍄🍄🍄🍄🍄 did update diary');
      return Diary.fromMap((response.data as dynamic));
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  Future<Diary> addDiary() async {
    try {
      final response = await dio.post(
        '${Secrets.baseURL}diary/create',
        data: {
          "user_id": 'iVEsnXvKgQOXe8GxjozT',
          "title": diary.title,
          "content": diary.content,
          "mood": "string",
          "weather": diary.weather,
          "post_at": DateTime.now().iso,
          "tags": diary.tags ?? []
        },
      );
      print('🍄🍄🍄🍄🍄 did save diary');
      return Diary.fromMap((response.data as dynamic));
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }
}

// final class DiaryDetailsController {
//   DiaryDetailsController({required this.diaryUsecase});

//   final DiaryUsecase diaryUsecase;

//   late Diary diary;
//   late DetailsPageKind kind;
//   final ValueNotifier<DetailsPageStatus> status =
//       ValueNotifier(DetailsPageStatus.initial);

//   final savedDiary = ValueNotifier(Diary());
//   // final currentPage = ValueNotifier(1);
//   // final isLastPage = ValueNotifier(false);

//   Future<void> add({required Diary entry}) async {
//     if (kind == DetailsPageKind.update) return;

//     status.value = DetailsPageStatus.loading;

//     final added = await diaryUsecase.add(entry: entry);
//     status.value = DetailsPageStatus.success;
//     savedDiary.value = added;
//   }
// }

