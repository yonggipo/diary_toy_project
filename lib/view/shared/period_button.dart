import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../application/common/app_color.dart';
import '../../application/utils/date_formatter.dart';

typedef PeriodChanged = void Function(DateTime startDate, DateTime endDate);

class PeriodButton extends StatefulWidget {
  const PeriodButton({required this.periodChanged, super.key});

  final PeriodChanged periodChanged;

  @override
  State<PeriodButton> createState() {
    return _PeriodButtonState();
  }
}

class _PeriodButtonState extends State<PeriodButton> {
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _endDate = DateTime.now();
    _startDate = DateTime(_endDate.year, _endDate.month, 1);
  }

  Future<void> _onTap(BuildContext context) async {
    DateTimeRange? pickedRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: _startDate,
        end: _endDate,
      ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedRange != null) {
      setState(() {
        _startDate = pickedRange.start;
        _endDate = pickedRange.end;
        widget.periodChanged(_startDate, _endDate);
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
              _startDate.toLocal().short,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.label,
              ),
            ),
            const Gap(8.0),
            Text(
              '-',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.label,
              ),
            ),
            const Gap(8.0),
            Text(
              _endDate.toLocal().short,
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
