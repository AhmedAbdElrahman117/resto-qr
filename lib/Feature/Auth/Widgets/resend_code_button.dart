import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';

class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({super.key, required this.seconds, this.onTap});

  final ValueNotifier<int> seconds;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: seconds,
      builder: (context, value, child) {
        return InkWell(
          onTap: value > 0 ? null : onTap,
          borderRadius: .circular(8),
          child: Container(
            margin: EdgeInsets.all(12),
            child: Text(
              AppLocalization.of(context).resendCode,
              style: AppText()
                  .caption(context)
                  .copyWith(
                    fontWeight: .w600,
                    color: value > 0 ? null : AppConstants().neonBlue,
                  ),
            ),
          ),
        );
      },
    );
  }
}
