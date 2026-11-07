import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({
    super.key,
    required this.isMandatory,
    required this.updateUrl,
  });

  final bool isMandatory;
  final String updateUrl;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return CustomDialog(
      child: Column(
        mainAxisSize: .min,
        children: [
          Text(
            l10n.updateAvailable,
            style: AppText().bold20(context),
          ),

          const SizedBox(height: 12),

          Text(
            isMandatory
                ? l10n.mandatoryUpdateDescription
                : l10n.optionalUpdateDescription,
            style: AppText().regular18(context),
            textAlign: .center,
          ),

          const SizedBox(height: 28),

          Row(
            mainAxisAlignment: .spaceEvenly,
            children: [
              if (!isMandatory)
                OutlinedButton(
                  onPressed: () {
                    Navigation().pop(context);
                  },
                  child: Text(
                    l10n.later,
                    style: AppText().regular16(context),
                  ),
                ),

              ElevatedButton(
                onPressed: () async {
                  try {
                    final Uri url = Uri.https(updateUrl);

                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } catch (e) {
                    log(e.toString());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants().neonBlue,
                ),
                child: Text(
                  l10n.updateNow,
                  style: AppText().regular16(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
