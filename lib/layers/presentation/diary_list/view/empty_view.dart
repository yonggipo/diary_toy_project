import 'package:flutter/material.dart';

import '../../app_color.dart';
import '../../app_text.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      DiaryListText.empty,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: AppColor.placeholder,
      ),
    );
  }
}
