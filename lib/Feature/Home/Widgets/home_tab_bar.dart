import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: .circular(8),
        side: BorderSide(
          color: AppTheme().borderColor(context),
          width: 1.5,
        ),
      ),
      child: TabBar(
        controller: tabController,
        indicatorSize: .tab,
        indicatorAnimation: .linear,
        dividerColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        indicator: BoxDecoration(
          color: AppConstants().neonBlue.withValues(alpha: 0.5),
          borderRadius: .circular(8),
        ),
        indicatorColor: AppConstants().neonBlue,
        labelStyle: AppText().bold14(context),
        unselectedLabelStyle: AppText().caption(context),
        tabs: [
          Tab(text: l10n.today),
          Tab(text: l10n.thisWeek),
          Tab(text: l10n.thisMonth),
        ],
      ),
    );
  }
}
