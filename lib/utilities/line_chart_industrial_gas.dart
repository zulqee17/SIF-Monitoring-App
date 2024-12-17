import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sif_monitoring/models/chart_data_model_industrailgas.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IndustrialGasLineChart extends StatelessWidget {
  const IndustrialGasLineChart({
    super.key,
    required this.chartData,
  });

  final List<ChartDataModelIndustrailgas> chartData;

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
      series: <LineSeries<ChartDataModelIndustrailgas, DateTime>>[
        LineSeries<ChartDataModelIndustrailgas, DateTime>(
          dataSource: chartData,
          xValueMapper: (ChartDataModelIndustrailgas data, _) => data.timestamp,
          yValueMapper: (ChartDataModelIndustrailgas data, _) => data.industrialGasValue,
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