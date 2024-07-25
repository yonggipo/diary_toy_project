import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../application/common/app_color.dart';
import '../../application/utils/date_formatter.dart';

final class DateLabel extends StatelessWidget {
  const DateLabel({super.key, this.date});

  final DateTime? date;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            'assets/icons/calendar.svg',
          ),
          const Gap(4.0),
          Text(
            (date ?? DateTime.now()).short,
            style: const TextStyle(
              color: AppColor.label,
              fontSize: 15,
            ),
          ),
        ],
      );
}
