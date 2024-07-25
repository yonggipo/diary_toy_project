import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'diary_list/diary_list.dart';
import '../binding/diary_list_binding.dart';

final class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/list',
      getPages: [
        GetPage(
            name: '/list',
            page: () => const DiaryList(),
            binding: DiaryListBinding()),
      ],
    );
  }
}
