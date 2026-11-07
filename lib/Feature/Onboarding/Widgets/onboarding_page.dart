import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Feature/Onboarding/Model/onboadring_page_model.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.page,
  });

  final OnboadringPageModel page;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: SvgPicture.asset(
            page.image,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 40),
        Expanded(
          child: Column(
            children: [
              Text(
                page.title,
                style: AppText().bold26(context),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text(
                page.description,
                style: AppText().caption(context).copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
