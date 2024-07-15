import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../app_color.dart';

class PeriodButton extends StatefulWidget {
  const PeriodButton({super.key});

  @override
  State<PeriodButton> createState() {
    return _PeriodButtonState();
  }
}

class _PeriodButtonState extends State<PeriodButton> {
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    endDate = DateTime.now();
    startDate = DateTime(endDate.year, endDate.month, 1);
  }

  Future<void> _onTap(BuildContext context) async {
    DateTimeRange? pickedRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: startDate,
        end: endDate,
      ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedRange != null) {
      setState(() {
        startDate = pickedRange.start;
        endDate = pickedRange.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 28),
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/calendar.svg',
            ),
            const Gap(8.0),
            Text(
              startDate.toLocal().short,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.label, // 텍스트 색상
              ),
            ),
            const Gap(8.0),
            Text(
              '-',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.label, // 텍스트 색상
              ),
            ),
            const Gap(8.0),
            Text(
              endDate.toLocal().short,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.label, // 텍스트 색상
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateFormatter on DateTime {
  String get short {
    final year = this.year.toString();
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return '$year.$month.$day';
  }
}
