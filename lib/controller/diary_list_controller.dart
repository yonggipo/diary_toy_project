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
  // final status = ValueNotifier(ListPageStatus.initial);
  final diaries = ValueNotifier(<Diary>[]);

  void updatePeriod(DateTime startDate, DateTime endDate) {
    startDate = startDate;
    endDate = endDate;
  }

  void updateTags(Tag tag) {
    currentTag = tag;
  }

  bool hasTag({List<String>? tags}) =>
      tags?.contains(currentTag.toCustomString()) ?? false;

  bool isInRange({DateTime? date}) =>
      date != null &&
      date.isAfter(startDate) &&
      date.isBefore(endDate.add(const Duration(days: 1)));

  // MARK: Life Cycle

  @override
  onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDiaryList();
    });
  }

  // MARK: API

  Future<void> fetchDiaryList() async {
    status.value = ListPageStatus.loading;
    late final List<Diary> list;
    try {
      final response = await dio.post(
          '${Secrets.baseURL}diary/list?user_id=${Secrets.userIdentifier}');

      list = (response.data!['entries'] as List<dynamic>)
          .map((e) => Diary.fromMap(e))
          .toList();
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }

    diaries.value = diaries.value..addAll(list);
    status.value = ListPageStatus.success;
  }

  Future<Diary> deleteDiary({required String entryIdentifier}) async {
    try {
      final response = await dio
          .delete('${Secrets.baseURL}diary/?entry_id=$entryIdentifier');

      return Diary.fromMap((response.data as dynamic));
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
        fetchDiaryList();
      });
    });
  }
}
