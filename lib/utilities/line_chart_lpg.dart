import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sif_monitoring/models/chart_data_model_lpg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LpgLineChart extends StatelessWidget {
  const LpgLineChart({
    super.key,
    required this.chartData,
  });

  final List<ChartDataModelLpg> chartData;

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
      series: <LineSeries<ChartDataModelLpg, DateTime>>[
        LineSeries<ChartDataModelLpg, DateTime>(
          dataSource: chartData,
          xValueMapper: (ChartDataModelLpg data, _) => data.timestamp,
          yValueMapper: (ChartDataModelLpg data, _) => data.lpgValue,
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