import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    super.key,
    this.onPressed,
    required this.label,
    required this.image,
  });

  final void Function()? onPressed;
  final String label;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(
        label,
        style: AppText().semiBold14(context),
      ),
      icon: SvgPicture.asset(
        image,
        width: 36,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme().fillColor(context),
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
          side: BorderSide(color: AppTheme().borderColor(context)),
        ),
      ),
    );
  }
}
