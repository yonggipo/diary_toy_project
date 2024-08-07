import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../application/common/app_color.dart';
import '../../application/utils/date_formatter.dart';
import '../../model/diary.dart';
import '../shared/tag_view.dart';

typedef OnListItemTap = void Function(Diary item);

final class DiaryListCell extends StatelessWidget {
  const DiaryListCell(
      {required this.item, required this.onListItemTap, super.key});

  final Diary item;
  final OnListItemTap onListItemTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onListItemTap.call(item),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.border,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/calendar.svg',
                    ),
                    const Gap(4.0),
                    Text(
                      item.createdAt.short,
                      style: const TextStyle(
                        color: AppColor.label,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: 44,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    item.content,
                    style: const TextStyle(
                      color: AppColor.label,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            TagView(tags: item.tags ?? [])
          ],
        ),
      ),
    );
  }
}
