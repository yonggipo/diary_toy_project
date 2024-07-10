import 'package:diary_toy_project/app_color.dart';
import 'package:diary_toy_project/sized_box_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PeriodButton extends StatefulWidget {
  const PeriodButton({super.key});

  @override
  State<PeriodButton> createState() {
    return _PeriodButton();
  }
}

class _PeriodButton extends State<PeriodButton> {
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    endDate = DateTime.now();
    startDate = DateTime(endDate.year, endDate.month, 1);
  }

  Future<void> _onPressed(BuildContext context) async {
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
    return FilledButton.tonal(
      onPressed: () => _onPressed(context),
      style: FilledButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              4.0,
            ),
          ),
        ),
        foregroundColor: AppColor.label,
        backgroundColor: AppColor.gray3,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/calendar.svg',
          ),
          SizedBoxUtils.normal,
          Text(
            startDate.toLocal().short(),
            style: const TextStyle(fontSize: 16),
          ),
          SizedBoxUtils.normal,
          const Text(
            '-',
            style: TextStyle(fontSize: 16),
          ),
          SizedBoxUtils.normal,
          Text(
            endDate.toLocal().short(),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

extension DateTimeFormat on DateTime {
  String short() =>
      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}
