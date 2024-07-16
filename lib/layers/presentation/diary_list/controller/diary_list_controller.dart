import 'package:diary_toy_project/layers/domain/usecase/diary_usecase.dart';
import 'package:flutter/foundation.dart';
import '../../../domain/diary/diary.dart';
import '../view_model/tag.dart';

enum ListPageStatus {
  initial,
  loading,
  success,
  failed,
}

final class DiaryListController {
  DiaryListController({required this.diaryUsecase});

  final DiaryUsecase diaryUsecase;

  final status = ValueNotifier(ListPageStatus.initial);
  final diaries = ValueNotifier(<Diary>[]);
  final currentPage = ValueNotifier(1);
  final isLastPage = ValueNotifier(false);

  Future<void> fetchList() async {
    if (isLastPage.value) return;

    status.value = ListPageStatus.loading;

    final list = await diaryUsecase.fetchList(page: currentPage.value);
    currentPage.value = currentPage.value + 1;
    diaries.value = diaries.value..addAll(list);
    status.value = ListPageStatus.success;
    isLastPage.value = true; // list.isEmpty;
  }
}
