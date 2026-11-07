import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: Divider(
            color: AppTheme().borderColor(context),
          ),
        ),
        Text(
          text,
          style: AppText().caption(context).copyWith(fontSize: 16),
        ),
        Expanded(
          child: Divider(
            color: AppTheme().borderColor(context),
          ),
        ),
      ],
    );
  }
}
