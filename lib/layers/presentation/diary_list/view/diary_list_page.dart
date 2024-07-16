import 'dart:ffi';

import 'package:diary_toy_project/layers/application/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:diary_toy_project/layers/application/common/app_text.dart';
import 'package:diary_toy_project/layers/presentation/shared/main_button.dart';

import '../view_model/tag.dart';
import '../../shared/segmented_control.dart';
import 'diary_list_view.dart';

final class DiaryListPage extends StatelessWidget {
  const DiaryListPage({super.key});

  @override
  Widget build(BuildContext context) => DiaryListView();
}
