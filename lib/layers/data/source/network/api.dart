import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../secrets.dart';
import '../../../domain/diary/diary.dart';
import '../../dto/diary/diary_dto.dart';

abstract class API {
  Future<List<Diary>> list({int page = 0});
  Future<Diary> detail({required String entryID});
  Future<Diary> update({required String entryID, required Diary entry});
  Future<Diary> add({required Diary entry});
  Future<Diary> delete({required String entryID});
}

final class DefaultAPI implements API {
  final dio = Dio();

  // MARK: Fetch Diary List

  @override
  // Future<List<Diary>> fetchDiaries({int page = 0}) async {
  Future<List<Diary>> list({int page = 0}) async {
    try {
      // final Response<Map<String, dynamic>> response = await dio.post('https://handler-ciqgffjs6q-du.a.run.app/diary/list?user_id=iVEsnXvKgQOXe8GxjozT');
      final Response<dynamic> response = await dio
          .post('${Secrets.baseURL}diary/list?user_id=iVEsnXvKgQOXe8GxjozT');
      Map<String, dynamic> dataMap = json.decode(response.data);
      // final l = (response.data!['entries'] as List<dynamic>)
      final l = (dataMap['entries'] as List<dynamic>)
          .map((e) => DiaryDTO.fromMap(e))
          .toList();
      return l;
    } on DioException catch (e) {
      if (e.response != null) {
        print('StatusCode: ${e.response?.statusCode}');
        print('Data: ${e.response?.data}');
        print('Headers: ${e.response?.headers}');
        if (e.response?.statusCode == 404) return [];
      } else {
        print('Unexpected error: $e');
      }
    }

    return [];
  }

  // MARK: Fetch Diary Detail

  @override
  Future<Diary> detail({required String entryID}) async {
    try {
      // final Response<Map<String, dynamic>> response = await dio.post('https://handler-ciqgffjs6q-du.a.run.app/diary/?entry_id=HVOMzzggPqFnB7utAG4N');
      final Response<dynamic> response = await dio
          .post('${Secrets.baseURL}diary/?entry_id=HVOMzzggPqFnB7utAG4N');
      Map<String, dynamic> dataMap = json.decode(response.data);
      // final l = (response as dynamic)
      final l = (dataMap as dynamic).map((e) => DiaryDTO.fromMap(e));
      return l;
    } on DioException catch (e) {
      if (e.response != null) {
        print('StatusCode: ${e.response?.statusCode}');
        print('Data: ${e.response?.data}');
        print('Headers: ${e.response?.headers}');
        (e.response?.statusCode == 404)
            ? throw Exception('Diary not found')
            : throw Exception('Network Error: ${e.error}');
      } else {
        print('Unexpected error: $e');
        rethrow;
      }
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  // MARK: Update Diary

  @override
  Future<Diary> update({
    required String entryID,
    required Diary entry,
  }) async {
    try {
      // final Response<Map<String, dynamic>> response = await dio.put('${Secrets.baseURL}diary/?entry_id=$entryID');
      final Response<dynamic> response = await dio.put(
        '${Secrets.baseURL}diary/?entry_id=$entryID',
        data: (entry as DiaryDTO).toJson(),
      );
      Map<String, dynamic> dataMap = json.decode(response.data);
      // (response as dynamic)
      return (dataMap as dynamic).map((e) => DiaryDTO.fromMap(e));
    } on DioException catch (e) {
      if (e.response != null) {
        print('StatusCode: ${e.response?.statusCode}');
        print('Data: ${e.response?.data}');
        print('Headers: ${e.response?.headers}');
        (e.response?.statusCode == 404)
            ? throw Exception('Diary not found')
            : throw Exception('Network Error: ${e.error}');
      } else {
        print('Unexpected error: $e');
        rethrow;
      }
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  // MARK: Add Diary

  @override
  Future<Diary> add({required Diary entry}) async {
    try {
      // final Response<Map<String, dynamic>> response = await dio.post('${Secrets.baseURL}diary/create');
      final Response<dynamic> response = await dio.post(
       '${Secrets.baseURL}diary/create',
        data: (entry as DiaryDTO).toJson(),
      );
      Map<String, dynamic> dataMap = json.decode(response.data);
      // (response as dynamic)
      return (dataMap as dynamic).map((e) => DiaryDTO.fromMap(e));
    } on DioException catch (e) {
      if (e.response != null) {
        print('StatusCode: ${e.response?.statusCode}');
        print('Data: ${e.response?.data}');
        print('Headers: ${e.response?.headers}');
        (e.response?.statusCode == 404)
            ? throw Exception('Diary not found')
            : throw Exception('Network Error: ${e.error}');
      } else {
        print('Unexpected error: $e');
        rethrow;
      }
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  // MARK: Delete Diary

  @override
  Future<Diary> delete({required String entryID}) async {
    try {
      // final Response<Map<String, dynamic>> response = await dio.delete('https://handler-ciqgffjs6q-du.a.run.app/diary/?entry_id=HVOMzzggPqFnB7utAG4N');
      final Response<dynamic> response = await dio
          .delete('${Secrets.baseURL}diary/?entry_id=$entryID');
      Map<String, dynamic> dataMap = json.decode(response.data);
      // final l = (response as dynamic)
      return (dataMap as dynamic).map((e) => DiaryDTO.fromMap(e));
    } on DioException catch (e) {
      if (e.response != null) {
        print('StatusCode: ${e.response?.statusCode}');
        print('Data: ${e.response?.data}');
        print('Headers: ${e.response?.headers}');
        (e.response?.statusCode == 404)
            ? throw Exception('Diary not found')
            : throw Exception('Network Error: ${e.error}');
      } else {
        print('Unexpected error: $e');
        rethrow;
      }
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }
}
