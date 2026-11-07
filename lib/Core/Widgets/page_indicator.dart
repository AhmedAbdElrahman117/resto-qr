import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.pageController,
    required this.pageCount,
  });

  final PageController pageController;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: pageCount,
      effect: ExpandingDotsEffect(
        activeDotColor: AppConstants().neonBlue,
        dotColor: AppTheme().secondaryText(context),
        spacing: 16,
      ),
    );
  }
}
