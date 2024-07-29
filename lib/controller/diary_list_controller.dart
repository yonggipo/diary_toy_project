import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../application/common/config/secrets.dart';
import '../binding/diary_details_binding.dart';
import '../model/diary.dart';
import '../model/tag.dart';
import '../view/diary_details/diary_details.dart';

enum ListPageStatus { initial, loading, success, failed }

final class DiaryListController extends GetxController {
  final dio = Dio();
  Tag currentTag = Tag.concert;
  final DateTime endDate = DateTime.now();
  late final DateTime startDate = DateTime(endDate.year, endDate.month, 1);
  final status = ListPageStatus.initial.obs;
  final diaries = <Diary>[].obs;
  List<Diary> _diaries = [];

  List<Diary> applyListSnapshot() => diaries.value =
      _diaries.where((e) => hasTag(e.tags) && isInRange(e.createdAt)).toList();

  void deleteDiary({required String diaryIdentifier}) {
    _deleteDiary(entryIdentifier: diaryIdentifier);
    _diaries.removeWhere((diary) => diary.entryIdentifier == diaryIdentifier);
    applyListSnapshot();
  }

  void updatePeriod(DateTime startDate, DateTime endDate) {
    startDate = startDate;
    endDate = endDate;
    applyListSnapshot();
  }

  void updateTags(Tag tag) {
    currentTag = tag;
    applyListSnapshot();
  }

  bool hasTag(List<String>? tags) =>
      tags?.contains(currentTag.toCustomString()) ?? false;

  bool isInRange(DateTime? date) =>
      date != null &&
      date.isAfter(startDate) &&
      date.isBefore(endDate.add(const Duration(days: 1)));

  // MARK: Life Cycle

  @override
  onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('🌕🌕🌕🌕🌕 initial fetch list');
      fetchDiaryList();
    });
  }

  // MARK: API

  Future<void> fetchDiaryList() async {
    status.value = ListPageStatus.loading;
    try {
      final response = await dio.post(
          '${Secrets.baseURL}diary/list?user_id=${Secrets.userIdentifier}');

      _diaries = (response.data!['entries'] as List<dynamic>)
          .map((e) => Diary.fromMap(e))
          .toList();
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }

    applyListSnapshot();
    status.value = ListPageStatus.success;
  }

  Future<String> _deleteDiary({required String entryIdentifier}) async {
    try {
      final response = await dio
          .delete('${Secrets.baseURL}diary/?entry_id=$entryIdentifier');
      var message = response.data['message'];
      print('delete api response: $message');
      return message;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  // MARK: - Route

  void addNewDiary() async {
    Get.to(
      const DiaryDetails(),
      binding: DiaryDetailsBinding(),
    )?.then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print('🍙🍙🍙 - Did fetch diaries after pop up');
        fetchDiaryList();
      });
    });
  }

  void updateDiary(Diary diary) async {
    Get.to(
      const DiaryDetails(),
      binding: DiaryDetailsBinding(diary: diary),
    )?.then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print('🍙🍙🍙 - Did fetch diaries after pop up');
        fetchDiaryList();
      });
    });
  }
}
