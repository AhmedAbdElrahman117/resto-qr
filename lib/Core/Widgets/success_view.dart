import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({
    super.key,
    required this.title,
    required this.message,
    this.showButton = false,
    this.buttonTitle,
    this.buttonIcon,
    this.onButtonPressed,
    required this.image,
  });

  final String image;
  final String title;
  final String message;
  final bool showButton;
  final String? buttonTitle;
  final IconData? buttonIcon;
  final void Function()? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        AspectRatio(
          aspectRatio: 1.25 / 1,
          child: checkImageType(),
        ),
        SizedBox(height: 40),
        Text(
          title,
          style: AppText().bold32(context),
          textAlign: .center,
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            message,
            style: AppText().regular18(context),
            textAlign: .center,
          ),
        ),
        SizedBox(height: 52),
        if (showButton)
          FullWidthButton(
            icon: buttonIcon,
            labelText: buttonTitle,
            onPressed: onButtonPressed,
          ),
      ],
    );
  }

  Widget checkImageType() {
    return image.endsWith('svg') ? SvgPicture.asset(image) : Image.asset(image);
  }
}
