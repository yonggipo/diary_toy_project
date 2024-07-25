import 'package:diary_toy_project/view/diary_list/diary_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../application/common/app_text.dart';

final class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: DiaryListText.navTitle,
      home: DiaryList(),
    );
  }
}
