import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resto_qr/Core/Widgets/cached_image.dart';

class UniversalImage extends StatelessWidget {
  final String source;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color; // Only used for SVGs
  final Widget? placeholder;
  final Widget? errorWidget;

  const UniversalImage({
    super.key,
    required this.source,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Check for Network URL (Always uses CachedNetworkImage)
    if (source.startsWith('http') || source.startsWith('https')) {
      return CachedImage(
        url: source,
        width: width,
        height: height,
        fit: fit,
      );
    }

    // 2. Determine if it is an SVG or a standard image
    final bool isSvg = source.toLowerCase().endsWith('.svg');
    final bool isAsset =
        source.startsWith('assets/') || source.startsWith('lib/');

    // 3. Handle Local Assets
    if (isAsset) {
      if (isSvg) {
        return SvgPicture.asset(
          source,
          width: width,
          height: height,
          fit: fit,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
        );
      } else {
        return Image.asset(
          source,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) =>
              errorWidget ?? const Icon(Icons.broken_image),
        );
      }
    }

    // 4. Handle Local Files (Filesystem)
    if (isSvg) {
      return SvgPicture.file(
        File(source),
        width: width,
        height: height,
        fit: fit,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    } else {
      return Image.file(
        File(source),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? const Icon(Icons.broken_image),
      );
    }
  }
}
