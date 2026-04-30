import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MarketChart extends StatelessWidget {
  const MarketChart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Simulate data points for Sun(0), Tue(2), Thu(4), Sun(7), Tue(9)
    // The x-axis represents days.
    // To achieve the "flat line between sessions", we use isStepLineChart: true
    final spots = [
      const FlSpot(0, 1000), // Dimanche
      const FlSpot(2, 1050), // Mardi
      const FlSpot(4, 1030), // Jeudi
      const FlSpot(7, 1080), // Dimanche
      const FlSpot(9, 1100), // Mardi
    ];

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                // Map x values to days
                switch (value.toInt()) {
                  case 0: return const Text('Dim');
                  case 2: return const Text('Mar');
                  case 4: return const Text('Jeu');
                  case 7: return const Text('Dim');
                  case 9: return const Text('Mar');
                  default: return const Text('');
                }
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 9,
        minY: 900,
        maxY: 1200,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false,
            isStepLineChart: true,
            lineChartStepData: const LineChartStepData(stepDirection: 0),
            color: theme.colorScheme.primary,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}
