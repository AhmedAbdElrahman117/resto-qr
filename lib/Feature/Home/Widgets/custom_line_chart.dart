import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class CustomLineChart extends StatelessWidget {
  const CustomLineChart({super.key, required this.data});

  final Map<String, double> data;

  @override
  Widget build(BuildContext context) {
    final tooltipStyle = AppText()
        .bold14(context)
        .copyWith(color: Colors.white);

    final bottomTitleStyle = AppText().semiBold14(context);

    // 2. Calculate dynamic width to enable scrolling
    // It takes the larger value: either the screen width (so it doesn't shrink if data is small),
    // or the data length multiplied by a fixed spacing (e.g., 60.0 pixels per point).
    final double chartWidth = math.max(
      MediaQuery.of(context).size.width,
      data.length *
          105.0, // Adjust this multiplier to change the spacing between points
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: chartWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: data.length.toDouble() - 1,
              clipData: const FlClipData.none(),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  fitInsideVertically: true,
                  fitInsideHorizontally: true,
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((LineBarSpot touchedSpot) {
                      return LineTooltipItem(
                        '${touchedSpot.y}',
                        tooltipStyle,
                      );
                    }).toList();
                  },
                  getTooltipColor: (touchedSpot) => Colors.blueGrey,
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(
                    data.length,
                    (index) => FlSpot(
                      index.toDouble(),
                      data.values.elementAt(index),
                    ),
                  ),
                  isCurved: true,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppConstants().neonBlue.withValues(alpha: 0.5),
                        AppConstants().neonBlue.withValues(alpha: 0.4),
                        AppConstants().neonBlue.withValues(alpha: 0.3),
                        AppConstants().neonBlue.withValues(alpha: 0.2),
                        AppTheme()
                            .primaryBackground(context)
                            .withValues(alpha: 0.12),
                      ],
                    ),
                  ),
                ),
              ],
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) => SideTitleWidget(
                      meta: meta,
                      space: 12,
                      fitInside: SideTitleFitInsideData.fromTitleMeta(
                        meta,
                        distanceFromEdge: 4,
                      ),
                      child: Text(
                        data.keys.elementAt(value.toInt()),
                        style: bottomTitleStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
