import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';
import 'package:resto_qr/Feature/Home/Models/dashboard_stats_model.dart';
import 'package:resto_qr/Feature/Home/View%20Model/Home%20Cubit/home_cubit.dart';
import 'package:resto_qr/Feature/Home/View%20Model/Home%20Cubit/home_state.dart';
import 'package:resto_qr/Feature/Home/Widgets/home_tab_bar.dart';
import 'package:resto_qr/Feature/Home/Widgets/period_stats.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return CustomContainer(
      padding: const .all(20),
      child: BlocWidget<HomeCubit, HomeState>(
        buildWhen: (prev, curr) =>
            curr is StatsLoadingState ||
            curr is StatsLoadedState ||
            curr is StatsErrorState,
        builder: (context, state) {
          var data = state is StatsLoadedState
              ? state.stats
              : EmptyDashboardStatsModel();

          return Skeletonizer(
            enabled: state is StatsLoadingState,
            child: Column(
              children: [
                HomeTabBar(tabController: tabController),
                const SizedBox(height: 28),
                AspectRatio(
                  aspectRatio: 1 / 1.7,
                  child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Today Stats
                      PeriodStats(
                        periodLabel: l10n.today,
                        totalMenuViews: data.todayStats.totalMenuViews + 5,
                        totalItemViews: data.todayStats.totalItemViews + 8,
                        totalPromoClicks:
                            data.todayStats.totalPromoClicks + 120,
                        growthPercentage: data.todayStats.growthPercentage + 7,
                        chartData: data.todayStats.chartData.map(
                          (key, value) => MapEntry(key, value.toDouble()),
                        ),
                      ),

                      // Week Stats
                      PeriodStats(
                        periodLabel: l10n.thisWeek,
                        totalMenuViews: data.weekStats.totalMenuViews,
                        totalItemViews: data.weekStats.totalItemViews,
                        totalPromoClicks: data.weekStats.totalPromoClicks,
                        growthPercentage: data.weekStats.growthPercentage,
                        chartData: data.weekStats.chartData.map(
                          (key, value) => MapEntry(key, value.toDouble()),
                        ),
                      ),

                      // Month Stats
                      PeriodStats(
                        periodLabel: l10n.thisMonth,
                        totalMenuViews: data.monthStats.totalMenuViews,
                        totalItemViews: data.monthStats.totalItemViews,
                        totalPromoClicks: data.monthStats.totalPromoClicks,
                        growthPercentage: data.monthStats.growthPercentage,
                        chartData: data.monthStats.chartData.map(
                          (key, value) => MapEntry(key, value.toDouble()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  PeriodStats mockupStats() {
    return PeriodStats(
      periodLabel: 'Today',
      totalMenuViews: 245,
      totalItemViews: 512,
      totalPromoClicks: 34,
      growthPercentage: 5.2,
      chartData: const {
        '8 AM': 10,
        '10 AM': 30,
        '12 PM': 85,
        '2 PM': 60,
        '4 PM': 25,
        '6 PM': 40,
        '8 PM': 110,
      },
    );
  }
}
