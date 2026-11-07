import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Widgets/universal_image.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.image,
  });

  final String? image;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        UniversalImage(
          source: image ?? Assets.imagesNoData,
          height: 160,
          width: 160,
        ),

        const SizedBox(height: 28),

        Text(
          title,
          style: AppText().semiBold24(context),
        ),

        const SizedBox(height: 4),

        Text(
          message,
          style: AppText().caption(context).copyWith(fontSize: 18),
          textAlign: .center,
        ),
      ],
    );
  }
}
