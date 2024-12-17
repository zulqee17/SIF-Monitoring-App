import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/chart_data_model_smoke.dart';


class SmokeLineChart extends StatelessWidget {
  const SmokeLineChart({
    super.key,
    required this.chartData,
  });

  final List<ChartDataModelSmoke> chartData;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        intervalType: DateTimeIntervalType.minutes,
        interval: 10,
        majorGridLines: const MajorGridLines(width: 0),
        dateFormat: DateFormat('dd/MM\nHH:mm'),
        labelStyle: const TextStyle(fontSize: 10),
        // labelRotation: -45,
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 1024,
        interval: 200,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      zoomPanBehavior: ZoomPanBehavior(
        enableDoubleTapZooming: true,
        enablePanning: true,
        enablePinching: true,
      ),
      series: <LineSeries<ChartDataModelSmoke, DateTime>>[
        LineSeries<ChartDataModelSmoke, DateTime>(
          dataSource: chartData,
          xValueMapper: (ChartDataModelSmoke data, _) => data.timestamp,
          yValueMapper: (ChartDataModelSmoke data, _) => data.smokeValue,
          animationDuration: 500,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
          ),
          markerSettings: const MarkerSettings(
            isVisible: true,
          ),
        ),
      ],
    );
  }
}