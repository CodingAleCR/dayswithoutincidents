import 'dart:math';

import 'package:dwi/core/theme/colors.dart';
import 'package:dwi/features/streaks_history/cubit/streaks_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Displays a list of streaks in a line chart.
class StreaksChart extends StatelessWidget {
  /// Displays a list of streaks in a line chart.
  const StreaksChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restarts = context.watch<StreaksCubit>().state.restarts;
    final primary = Theme.of(context).colorScheme.primary;
    // TODO(codingalecr): Improve color scheme handling.
    final secondary = Theme.of(context).textTheme.bodyText1?.color;
    final lastTenRestarts = restarts.take(10).toList();

    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: false,
              checkToShowVerticalLine: (value) => false,
            ),
            titlesData: FlTitlesData(show: false),
            maxY:
                lastTenRestarts.map((r) => r.streak).reduce(max).toDouble() + 4,
            minY: -10,
            borderData: FlBorderData(show: false),
            lineTouchData: LineTouchData(
              getTouchedSpotIndicator: (
                LineChartBarData barData,
                List<int> indicators,
              ) {
                return indicators.map((int index) {
                  /// Indicator Line
                  const lineStrokeWidth = 4.0;
                  final flLine = FlLine(
                    color: primary,
                    strokeWidth: lineStrokeWidth,
                  );

                  var dotSize = 10.0;
                  if (barData.dotData.show) {
                    dotSize = 4.0 * 1.8;
                  }

                  final dotData = FlDotData(
                    getDotPainter: (spot, percent, bar, index) =>
                        FlDotCirclePainter(
                      radius: dotSize,
                      color: primary,
                      strokeColor: secondary,
                      strokeWidth: 2,
                    ),
                  );

                  return TouchedSpotIndicatorData(flLine, dotData);
                }).toList();
              },
              touchTooltipData: LineTouchTooltipData(
                fitInsideHorizontally: true,
                tooltipBgColor: DWIColors.brandBlue,
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    const textStyle = TextStyle(
                      color: DWIColors.brandWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    );
                    return LineTooltipItem(
                      '${touchedSpot.y.toInt().toString()} days',
                      textStyle,
                    );
                  }).toList();
                },
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: lastTenRestarts
                    .asMap()
                    .entries
                    .map(
                      (entry) => FlSpot(
                        entry.key.toDouble(),
                        entry.value.streak.toDouble(),
                      ),
                    )
                    .toList(),
                preventCurveOverShooting: true,
                isCurved: true,
                barWidth: 5,
                isStrokeCapRound: true,
                color: secondary,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (
                    FlSpot spot,
                    double xPercentage,
                    LineChartBarData bar,
                    int index, {
                    double? size,
                  }) =>
                      FlDotCirclePainter(
                    radius: size,
                    color: primary,
                    strokeColor: secondary,
                  ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
