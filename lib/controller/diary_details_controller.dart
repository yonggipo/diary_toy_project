import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kpostal/kpostal.dart';

import '../application/common/config/secrets.dart';
import '../application/utils/alert.dart';
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
  late GoogleMapController mapController;
  final LatLng center = const LatLng(45.521563, -122.677433);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void updateTitle(String title) {
    diary.title = title;
  }

  void updateContent(String content) {
    diary.content = content;
  }

  void updateWeather(Weather weather) {
    diary.weather = weather.toCustomString();
  }

  void updateTags(List<String> tags) {
    diary.tags = tags;
  }

  // MARK: - Location

  void searchAddress({required BuildContext context}) async {
    print('💥💥💥 Did Search Address Button Tapped 💥💥💥');
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KpostalView(
          callback: (Kpostal result) {
            debugPrint(result.toString());
          },
        ),
      ),
    );
  }

  void updateLocation({required int locationIndex}) async {
    print('💥💥💥 Did Update Loaction Button Tapped 💥💥💥');
  }

  void deleteLocation() {
    //  {
//                   locations.removeAt(index);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('$item dismissed'),
//                     ),
//                   )
  }

  String? validateText({String? value, String? message}) {
    final trimmed = value?.trim();
    final isValid = (trimmed != null && trimmed.isNotEmpty);
    print('input text value: $value, is valid: $isValid');
    return isValid ? null : message;
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

  // MARK: - API

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
