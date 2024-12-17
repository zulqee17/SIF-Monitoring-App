import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sif_monitoring/controller/fire_screen_controller.dart';

import '../../utilities/app_text_styles.dart';
import '../../utilities/colors.dart';
import '../../utilities/reusable_widgets.dart';

class FireMonitorScreen extends StatefulWidget {
  const FireMonitorScreen({super.key});

  @override
  State<FireMonitorScreen> createState() => _FireMonitorScreenState();
}

class _FireMonitorScreenState extends State<FireMonitorScreen> {

  final FireScreenController fireScreenController=Get.put(FireScreenController());

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.secoundaryColor,
        title: Text('Fire Monitoring',style: AppTextStyles.appBarTextStyle,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*.01,),
              ReusableWidgets.headingText('Fire Monitoring Status'),
              SizedBox(height: height*.01,),
              SizedBox(
                height: height*.75,
                child: StreamBuilder<Map>(
                    stream: fireScreenController.getStreamData,
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: SpinKitFadingCircle(
                          color: AppColors.primaryColor,
                          size: 40,
                        ));
                      }else{
                        var data=snapshot.data!;
                        fireScreenController.updateValue(data);
                        return Column(
                          children: [
                            Obx((){
                              return Card(
                                  color: AppColors.primaryColor,
                                  child: SizedBox(
                                    height: height*.4,
                                    width: double.infinity,
                                    // ignore: unrelated_type_equality_checks
                                    child: fireScreenController.flame1==1?Image.asset('images/flame-removebg.png'):Image.asset('images/flame-removebg-bw.png'),
                                  )
                              );
                            }),
                            SizedBox(height: height*.01,),
                            Obx((){
                              return ReusableWidgets.digitalValueContainer(context, 'Fire Status', fireScreenController.flame1.value);
                            }),
                            SizedBox(height: height*.01,),
                            Obx((){
                              return ReusableWidgets.fireMessageContainer(context, 'fire', fireScreenController.flame1.value);
                            })
                          ],
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
