import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class OtpTimer extends StatelessWidget {
  const OtpTimer({super.key, required this.seconds});

  final ValueNotifier<int> seconds;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: AppTheme().fillColor(context),
        border: Border.all(width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // Spacing is available in newer Flutter versions, otherwise use SizedBox
        children: [
          FaIcon(
            FontAwesomeIcons.stopwatch,
            color: AppTheme().iconColor(context),
          ),
          const SizedBox(width: 8), // Added explicit spacing for safety
          ValueListenableBuilder<int>(
            valueListenable: seconds,
            builder: (context, value, child) {
              // 1. Calculate Minutes (Integer Division)
              final minutes = (value ~/ 60).toString().padLeft(2, '0');

              // 2. Calculate Remaining Seconds (Modulo)
              final seconds = (value % 60).toString().padLeft(2, '0');

              return RichText(
                text: TextSpan(
                  text: l10n.resendCodeIn,
                  style: AppText().regular14(context),
                  children: [
                    TextSpan(
                      // 3. Display calculated variables
                      text: ' $minutes:$seconds',
                      style: AppText().bold14(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
