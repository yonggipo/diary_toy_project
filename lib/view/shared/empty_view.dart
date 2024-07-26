import 'package:flutter/material.dart';

import '../../application/common/app_color.dart';
import '../../application/common/app_text.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        DiaryListText.empty,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: AppColor.placeholder,
        ),
      ),
    );
  }
}
