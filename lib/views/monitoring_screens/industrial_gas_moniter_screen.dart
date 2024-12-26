import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sif_monitoring/controller/industrial_gas_screen_controller.dart';
import 'package:sif_monitoring/models/chart_data_model_industrailgas.dart';
import 'package:sif_monitoring/utilities/line_chart_industrial_gas.dart';

import '../../utilities/app_text_styles.dart';
import '../../utilities/colors.dart';
import '../../utilities/reusable_widgets.dart';

class IndustrialGasMonitorScreen extends StatefulWidget {
  const IndustrialGasMonitorScreen({super.key});

  @override
  State<IndustrialGasMonitorScreen> createState() =>
      _IndustrialGasMonitorScreenState();
}

class _IndustrialGasMonitorScreenState
    extends State<IndustrialGasMonitorScreen> {
  final IndustrialGasScreenController indGasController =
      Get.put(IndustrialGasScreenController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.secoundaryColor,
        title: Column(
          children: [
            Text('Industrial Gas', style: AppTextStyles.appBarTextStyle),
            Text('Monitoring', style: AppTextStyles.appBarTextStyle),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.01),
              ReusableWidgets.headingText('Industrial Gas Monitoring Level'),
              SizedBox(height: height * 0.01),
              SizedBox(
                height: height * 0.756,
                child: StreamBuilder<Map>(
                  stream: indGasController.getStreamData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: AppColors.primaryColor,
                          size: 40,
                        ),
                      );
                    } else {
                      final data = snapshot.data!;
                      indGasController.updateValue(data);
                      return Column(
                        children: [
                          Obx(() {
                            return ReusableWidgets.moniteringGuage(
                                indGasController.indGasValue.toDouble());
                          }),
                          SizedBox(height: height * 0.01),
                          Obx(() {
                            return ReusableWidgets.digitalValueContainer(
                                context,
                                'Industrial Gas Value',
                                indGasController.indGasValue.toInt());
                          }),
                          SizedBox(height: height * 0.01),
                          Obx(() {
                            return ReusableWidgets.messageContainer(
                                context,
                                'Industrial gas',
                                indGasController.indGasValue.toInt());
                          }),
                        ],
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: height * 0.03),
              ReusableWidgets.headingText('Storage Graph'),
              SizedBox(
                height: height * 0.35,
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: indGasController.getStoredData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: AppColors.primaryColor,
                          size: 40,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Failed to get data'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    } else {
                      final data = snapshot.data!;

                      // Transform Firestore data into chart-compatible format
                      final chartData = data.map((entry) {
                        final dateTime =
                            (entry['timestamp'] as Timestamp).toDate();
                        final industrialGasValue =
                            entry['industrialGasValue'] as double;
                        return ChartDataModelIndustrailgas(
                            dateTime, industrialGasValue);
                      }).toList();

                      // Dynamically adjust chart width based on the number of data points
                      final chartWidth = chartData.length * 50.0;

                      return Card(
                        color: Colors.lightBlue.shade50,
                        child: SingleChildScrollView(
                          scrollDirection:
                              Axis.horizontal, // Enable horizontal scrolling
                          child: SizedBox(
                            width: chartWidth <
                                    MediaQuery.of(context).size.width
                                ? MediaQuery.of(context).size.width
                                : chartWidth, // Ensure a minimum width equal to screen width
                            child: IndustrialGasLineChart(chartData: chartData),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
