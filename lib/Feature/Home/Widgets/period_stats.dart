import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Feature/Home/Widgets/custom_line_chart.dart';

class PeriodStats extends StatelessWidget {
  const PeriodStats({
    super.key,
    required this.totalMenuViews,
    required this.totalItemViews,
    required this.totalPromoClicks,
    required this.growthPercentage,
    required this.periodLabel,
    required this.chartData,
  });

  final int totalMenuViews;
  final int totalItemViews;
  final int totalPromoClicks;
  final double growthPercentage;
  final String periodLabel;
  final Map<String, double> chartData;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    final bool isPositiveGrowth = growthPercentage >= 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main metric (Menu Views) matching DB structure for menus.views_count
        Text(
          l10n.totalMenuViews,
          style: AppText().semiBold16(context),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalization.formatNumber(totalMenuViews, context: context),
          style: AppText().bold28(context),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: '$periodLabel ',
            style: AppText().regular16(context),
            children: [
              TextSpan(
                text:
                    '${isPositiveGrowth ? '+' : ''}${AppLocalization.formatPercent(
                      growthPercentage,
                      context: context,
                      decimalDigits: 1,
                    )}',
                style: AppText()
                    .semiBold16(context)
                    .copyWith(
                      color: isPositiveGrowth
                          ? AppConstants().successColor
                          : AppConstants().errorRed,
                    ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Horizontal metric cards matching other key performance indicators from db.md
        Row(
          children: [
            Expanded(
              child: _buildSecondaryStatCard(
                context,
                title: l10n.itemViews,
                value: AppLocalization.formatNumber(
                  totalItemViews,
                  context: context,
                ),
                icon: Icons.visibility_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSecondaryStatCard(
                context,
                title: l10n.promoClicks,
                value: AppLocalization.formatNumber(
                  totalPromoClicks,
                  context: context,
                ),
                icon: Icons.touch_app_outlined,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Expanded(
          child: CustomLineChart(
            data: chartData,
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const .all(12),
      decoration: BoxDecoration(
        color: AppConstants().neonBlue.withValues(alpha: 0.05),
        borderRadius: .circular(12),
        border: .all(
          color: AppConstants().neonBlue.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: AppConstants().neonBlue,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppText().caption(context),
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppText().semiBold18(context),
          ),
        ],
      ),
    );
  }
}
