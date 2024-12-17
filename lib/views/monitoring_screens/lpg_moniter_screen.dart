import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sif_monitoring/controller/lpg_screen_controller.dart';
import 'package:sif_monitoring/utilities/line_chart_lpg.dart';

import '../../models/chart_data_model_lpg.dart';
import '../../utilities/app_text_styles.dart';
import '../../utilities/colors.dart';
import '../../utilities/reusable_widgets.dart';

class LPGMonitorScreen extends StatefulWidget {
  const LPGMonitorScreen({super.key});

  @override
  State<LPGMonitorScreen> createState() => _LPGMonitorScreenState();
}

class _LPGMonitorScreenState extends State<LPGMonitorScreen> {
  final LpgScreenController lpgScreenController=Get.put(LpgScreenController());

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.secoundaryColor,
        title: Text('LPG Monitoring',style: AppTextStyles.appBarTextStyle,),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*.01,),
              ReusableWidgets.headingText('LPG Monitoring Level'),
              SizedBox(height: height*.01,),
              SizedBox(
                height: height*0.756,
                child: StreamBuilder<Map>(
                    stream: lpgScreenController.getStreamData,
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: SpinKitFadingCircle(
                          color: AppColors.primaryColor,
                          size: 40,
                        ));
                      }else{
                        final data=snapshot.data!;
                        lpgScreenController.updateValue(data);
                        return Column(
                          children: [
                            Obx((){
                              return ReusableWidgets.moniteringGuage(lpgScreenController.lpg.toDouble());
                            }),
                            SizedBox(height: height*.01,),
                            Obx((){
                              return ReusableWidgets.digitalValueContainer(context, 'LPG Value', lpgScreenController.lpg.toInt());
                            }),
                            SizedBox(height: height*.01,),
                            Obx((){
                              return ReusableWidgets.messageContainer(context, 'LPG', lpgScreenController.lpg.toInt());
                            })
                          ],
                        );
                      }
                    }
                ),
              ),
              SizedBox(height: height*.03,),
              ReusableWidgets.headingText('Storage Graph'),
              SizedBox(
                height: height*.35,
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: lpgScreenController.getStoredData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: SpinKitFadingCircle(
                        color: AppColors.primaryColor,
                        size: 40,
                      ));
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Failed to get data'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    } else {
                      final data = snapshot.data!;

                      // Transform Firestore data into chart-compatible format
                      final chartData = data.map((entry) {
                        final dateTime = (entry['timestamp'] as Timestamp).toDate();
                        final lpgValue = entry['lpgValue'] as double;
                        return ChartDataModelLpg(dateTime, lpgValue);
                      }).toList();

                      // Dynamically adjust chart width based on the number of data points
                      final chartWidth = chartData.length * 50.0;

                      return Card(
                        color: Colors.lightBlue.shade50,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                          child: SizedBox(
                            width: chartWidth < MediaQuery.of(context).size.width
                                ? MediaQuery.of(context).size.width
                                : chartWidth, // Ensure a minimum width equal to screen width
                            child: LpgLineChart(chartData: chartData),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: height*.03,),
            ],
          ),
        ),
      ),
    );
  }
}
