import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../application/common/config/secrets.dart';
import '../application/utils/date_formatter.dart';
import '../model/diary.dart';
import '../model/weather.dart';

enum DetailsPageStatus { initial, loading, success, failed }

enum DetailsPageKind { add, update }

final class AlertAction {
  const AlertAction({this.title, this.onTap});

  final title;
  final onTap;
}

Future<void> showAlert({
  required context,
  required String title,
  required String body,
  required List<AlertAction> actions,
}) async {
  return showDialog<void>(
    context: context,
    // barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(body),
          ],
        ),
      ),
      actions: actions
          .map((e) => TextButton(
                onPressed: e.onTap,
                child: Text(e.title),
              ))
          .toList(),
    ),
  );
}

final class DiaryDetailsController extends GetxController {
  DiaryDetailsController({required this.diary, required this.kind});

  final dio = Dio();
  final Diary diary;
  final DetailsPageKind kind;

  updateTitle(String title) => diary.title = title;

  updateContent(String content) => diary.content = content;

  updateWeather(Weather weather) => diary.weather = weather.toCustomString();

  updateTags(List<String> tags) => diary.tags = tags;

  String? validateText({String? value, String? message}) {
    final trimmed = value?.trim();
    final isValid = (trimmed != null && trimmed.isNotEmpty);
    print('input text value: $value, is valid: $isValid');
    return isValid ? null : message;
  }

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

  bool isValid() {
    // title validation
    var trimmed = diary.title.trim();
    print('🐳🐳🐳 - trimmed: $trimmed');
    return trimmed.isNotEmpty;
  }

  void saveDiary({required BuildContext context}) async {
    if (!isValid()) {
      showAlert(
        context: context,
        title: '',
        body: '제목을 입력해주세요',
        actions: [
          AlertAction(
            title: '확인',
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      showAlert(
        context: context,
        title: '',
        body: '저장하겠습니까?',
        actions: [
          AlertAction(
              title: '네',
              onTap: () async {
                (kind == DetailsPageKind.add)
                    ? await addDiary()
                    : await updateDiary();
                if (!context.mounted) return;
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }),
          AlertAction(
            title: '아니오',
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
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
