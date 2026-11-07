import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Feature/Home/Widgets/custom_line_chart.dart';

class WeeklyStats extends StatelessWidget {
  const WeeklyStats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: .start,
      children: [
        Text(
          'Total Menu Visits',
          style: AppText().semiBold16(context),
        ),
        Text(
          '1204',
          style: AppText().bold28(context),
        ),
        RichText(
          text: TextSpan(
            text: 'This week ',
            style: AppText().regular16(context),
            children: [
              TextSpan(
                text: '+15%',
                style: AppText()
                    .semiBold16(context)
                    .copyWith(
                      color: AppConstants().successColor,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Expanded(
          child: CustomLineChart(
            data: {
              'Sat': 100,
              'Sun': 70,
              'Mon': 80,
              'Tue': 65,
              'Wed': 88,
              'Thu': 45,
              'Fri': 20,
            },
          ),
        ),
      ],
    );
  }
}
