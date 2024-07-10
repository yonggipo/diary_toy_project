import 'package:flutter/material.dart';

import 'package:diary_toy_project/app_text.dart';
import 'package:diary_toy_project/diary_main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppText.diaryMainNavTitle,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const DiaryMainPage(),
    );
  }
}
