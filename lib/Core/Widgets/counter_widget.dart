import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const .symmetric(horizontal: 10, vertical: 4),
      color: AppConstants().neonBlue.withValues(alpha: 0.12),
      borderRadius: 20,
      child: Text(
        AppLocalization.formatNumber(count, context: context),
        style: AppText().bold14(context, AppConstants().neonBlue),
      ),
    );
  }
}
