import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = .cover,
    this.borderRadius,
  });

  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? .zero,
      child: url != null && url!.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: url!,
              width: width,
              height: height,
              fit: fit,
              progressIndicatorBuilder: (context, url, progress) =>
                  Skeletonizer(
                    enabled: true,
                    enableSwitchAnimation: true,
                    containersColor: AppConstants().neonBlue.withValues(
                      alpha: 0.25,
                    ),
                    child: SizedBox(
                      width: width,
                      height: height,
                    ),
                  ),
              errorWidget: (context, url, error) => Container(
                color: AppTheme().borderColor(context),
                width: width,
                height: height,
                child: FittedBox(
                  fit: .scaleDown,
                  child: Icon(
                    Icons.image_not_supported,
                    color: AppTheme().iconColor(context),
                  ),
                ),
              ),
            )
          : Image.asset(
              Assets.imagesNoImageAvailable,
              width: width,
              height: height,
              fit: fit,
            ),
    );
  }
}
