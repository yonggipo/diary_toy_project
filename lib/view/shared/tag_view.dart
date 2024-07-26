import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../application/common/app_color.dart';

final class TagView extends StatelessWidget {
  const TagView({required this.tags, super.key});

  final List<String> tags;

  Container createTagLabel(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColor.unSelectedBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.normal,
          color: AppColor.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (int i = 0; i < tags.length; i++) ...[
          createTagLabel(tags[i]),
          if (i < tags.length - 1) const Gap(4.0),
        ],
      ],
    );
  }
}
