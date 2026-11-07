import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget({super.key, required this.data, this.embeddedImage});

  final String data;
  final ImageProvider<Object>? embeddedImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(8),
      child: QrImageView(
        data: data,
        version: QrVersions.auto,
        size: 240,
        backgroundColor: Colors.white,
        constrainErrorBounds: true,
        gapless: true,
        embeddedImageEmitsError: true,
        embeddedImage: embeddedImage,
        errorStateBuilder: (context, error) {
          return Column(
            mainAxisAlignment: .center,
            spacing: 12,
            children: [
              Icon(
                Icons.error,
                color: AppConstants().errorRed,
                size: 40,
              ),
              Text(
                'Uh oh! Something went wrong...',
                textAlign: TextAlign.center,
                style: AppText().bold20(
                  context,
                  AppConstants().errorRed,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
