import 'package:resto_qr/Feature/Home/Models/stats_model.dart';

class DashboardStatsModel {
  final StatsModel todayStats;
  final StatsModel weekStats;
  final StatsModel monthStats;

  DashboardStatsModel({
    required this.todayStats,
    required this.weekStats,
    required this.monthStats,
  });

  factory DashboardStatsModel.fromMap(Map<String, dynamic> map) {
    return DashboardStatsModel(
      todayStats: StatsModel.fromMap(map['day']),
      weekStats: StatsModel.fromMap(map['week']),
      monthStats: StatsModel.fromMap(map['month']),
    );
  }
}

class EmptyDashboardStatsModel extends DashboardStatsModel {
  EmptyDashboardStatsModel()
    : super(
        todayStats: StatsModel(
          totalMenuViews: 0,
          totalItemViews: 0,
          totalPromoClicks: 0,
          growthPercentage: 0.0,
          chartData: {},
        ),
        weekStats: StatsModel(
          totalMenuViews: 0,
          totalItemViews: 0,
          totalPromoClicks: 0,
          growthPercentage: 0.0,
          chartData: {},
        ),
        monthStats: StatsModel(
          totalMenuViews: 0,
          totalItemViews: 0,
          totalPromoClicks: 0,
          growthPercentage: 0.0,
          chartData: {},
        ),
      );
}
