import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/page_indicator.dart';
import 'package:resto_qr/Feature/Onboarding/Model/onboadring_page_model.dart';
import 'package:resto_qr/Feature/Onboarding/Widgets/onboarding_page.dart';
import 'package:resto_qr/Feature/Onboarding/Widgets/page_switch_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  late int pageCount;

  List<OnboadringPageModel> get pages {
    final l10n = AppLocalization.current;
    return [
      OnboadringPageModel(
        image: Assets.imagesOnboarding1,
        title: l10n.registerRestaurant,
        description: l10n.registerRestaurantDescription,
      ),
      OnboadringPageModel(
        image: Assets.imagesOnboarding2,
        title: l10n.buildYourMenu,
        description: l10n.buildYourMenuDescription,
      ),
      OnboadringPageModel(
        image: Assets.imagesOnboarding3,
        title: l10n.generateQrCodes,
        description: l10n.generateQrCodesDescription,
      ),
      OnboadringPageModel(
        image: Assets.imagesOnboarding4,
        title: l10n.dataDrivenDecisions,
        description: l10n.dataDrivenDecisionsDescription,
      ),
      OnboadringPageModel(
        image: Assets.imagesOnboarding5,
        title: l10n.manageMultipleBranches,
        description: l10n.manageMultipleBranchesDescription,
      ),
    ];
  }

  final ValueNotifier<bool> currentPage = ValueNotifier(false);

  @override
  void initState() {
    pageCount = pages.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 28,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    currentPage.value = value == pageCount - 1;
                  },
                  itemCount: pageCount,
                  itemBuilder: (context, index) {
                    var page = pages[index];
                    return OnboardingPage(page: page);
                  },
                ),
              ),
            ),

            PageIndicator(
              pageController: _pageController,
              pageCount: pageCount,
            ),

            SizedBox(height: 4),

            PageSwitchButton(
              pageController: _pageController,
              isLastPage: currentPage,
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
