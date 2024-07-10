import 'package:diary_toy_project/sized_box_utils.dart';
import 'package:flutter/material.dart';

import 'package:diary_toy_project/app_text.dart';
import 'package:diary_toy_project/app_color.dart';
import 'package:diary_toy_project/period_button.dart';

class DiaryMainPage extends StatefulWidget {
  const DiaryMainPage({super.key});

  @override
  State<DiaryMainPage> createState() {
    return _DiaryMainPageState();
  }
}

class _DiaryMainPageState extends State<DiaryMainPage> {
  void writeDiary() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppText.diaryMainNavTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600, // SemiBold
          ),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PeriodButton(),
            SizedBoxUtils.threeX,
            Text(
              AppText.emptyContentMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.placeholder,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: writeDiary,
        tooltip: 'Write Diary',
        child: const Text(
          AppText.writeDiray,
          style: TextStyle(),
        ),
      ),
    );
  }
}
