class StatsModel {
  final int totalMenuViews;
  final int totalItemViews;
  final int totalPromoClicks;
  final double growthPercentage;
  final Map<String, dynamic> chartData;

  StatsModel({
    required this.totalMenuViews,
    required this.totalItemViews,
    required this.totalPromoClicks,
    required this.growthPercentage,
    required this.chartData,
  });

  factory StatsModel.fromMap(Map<String, dynamic> map) {
    return StatsModel(
      totalMenuViews: map['totalMenuViews'] as int,
      totalItemViews: map['totalItemViews'] as int,
      totalPromoClicks: map['totalPromoClicks'] as int,
      growthPercentage: map['growthPercentage'] as double,
      chartData: Map<String, dynamic>.from(map['chartData']),
    );
  }
}
