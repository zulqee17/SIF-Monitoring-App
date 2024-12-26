import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../controller/smoke_screen_controller.dart';
import '../../models/chart_data_model_smoke.dart';
import '../../utilities/app_text_styles.dart';
import '../../utilities/colors.dart';
import '../../utilities/line_chart_smoke.dart';
import '../../utilities/reusable_widgets.dart';

class SmokeMonitorScreen extends StatefulWidget {
  const SmokeMonitorScreen({super.key});

  @override
  State<SmokeMonitorScreen> createState() => _SmokeMonitorScreenState();
}

class _SmokeMonitorScreenState extends State<SmokeMonitorScreen> {
  final SmokeScreenController smokeController =
      Get.put(SmokeScreenController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.secoundaryColor,
        title: Text(
          'Smoke Monitoring',
          style: AppTextStyles.appBarTextStyle,
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
              SizedBox(height: height * .01),
              ReusableWidgets.headingText('Smoke Monitoring Level'),
              SizedBox(height: height * .01),
              SizedBox(
                height: height * .756,
                child: StreamBuilder<Map>(
                  stream: smokeController.getStreamData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: AppColors.primaryColor,
                          size: 40,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text('No data available'));
                    } else {
                      final data = snapshot.data!;
                      smokeController.updateValue(data);

                      return Column(
                        children: [
                          Obx(() {
                            return ReusableWidgets.moniteringGuage(
                                smokeController.smoke1.value);
                          }),
                          SizedBox(height: height * .01),
                          Obx(() {
                            return ReusableWidgets.digitalValueContainer(
                                context,
                                'Smoke Value',
                                smokeController.smoke1.value.toInt());
                          }),
                          SizedBox(height: height * .01),
                          Obx(() {
                            return ReusableWidgets.messageContainer(context,
                                'smoke', smokeController.smoke1.value.toInt());
                          }),
                        ],
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: height * .03),
              ReusableWidgets.headingText('Storage Graph'),
              SizedBox(
                height: height * .35,
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: smokeController.getStoredData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: AppColors.primaryColor,
                          size: 40,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Failed to get data: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    } else {
                      final data = snapshot.data!;

                      // Transform Firestore data into chart-compatible format
                      final chartData = data.map((entry) {
                        final dateTime =
                            (entry['timestamp'] as Timestamp).toDate();
                        final smokeValue = entry['smokeValue'] as double;
                        return ChartDataModelSmoke(dateTime, smokeValue);
                      }).toList();

                      // Dynamically adjust chart width based on the number of data points
                      final chartWidth = chartData.length *
                          50.0; // Adjust scaling factor as needed

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
                            child: SmokeLineChart(chartData: chartData),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: height * .03),
            ],
          ),
        ),
      ),
    );
  }
}
