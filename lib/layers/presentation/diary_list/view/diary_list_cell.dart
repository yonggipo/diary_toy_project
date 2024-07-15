import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../domain/diary/diary.dart';
import '../../app_color.dart';
import 'tag_view.dart';

final class DiaryListCell extends StatefulWidget {
  const DiaryListCell({required this.item, super.key});

  final Diary item;

  @override
  State<DiaryListCell> createState() {
    return _DiaryListCellState();
  }
}

class _DiaryListCellState extends State<DiaryListCell> {
  String formatDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year.$month.$day';
  }

  @override
  Widget build(BuildContext context) => Container(
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
                  widget.item.title ?? "",
                  style: TextStyle(
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
                      widget.item.createdAt?.short ?? "",
                      style: TextStyle(
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
                    widget.item.content ?? "",
                    style: TextStyle(
                      color: AppColor.label,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            TagView(tags: widget.item.tags ?? [])
          ],
        ),
      );
}

extension DateFormatter on DateTime {
  String get short {
    final year = this.year.toString();
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return '$year.$month.$day';
  }
}
