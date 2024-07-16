import 'package:flutter/material.dart';

import '../application/common/app_text.dart';
import 'diary_list/view/diary_list_page.dart';

final class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: DiaryListText.navTitle,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            DiaryListText.navTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: false,
        ),
        body: const DiaryListPage(),
      ),
    );
  }
}
