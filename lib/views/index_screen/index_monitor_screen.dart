import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/index_screen_controller.dart';
import '../../utilities/app_text_styles.dart';
import '../../utilities/colors.dart';
import '../../utilities/reusable_widgets.dart';
import '../monitoring_screens/fire_moniter_screen.dart';
import '../monitoring_screens/industrial_gas_moniter_screen.dart';
import '../monitoring_screens/lpg_moniter_screen.dart';
import '../monitoring_screens/smoke_moniter_screen.dart';


class IndexMonitorScreen extends StatefulWidget {
  const IndexMonitorScreen({super.key});

  @override
  State<IndexMonitorScreen> createState() => _IndexMonitorScreenState();
}

class _IndexMonitorScreenState extends State<IndexMonitorScreen> {
  final _indexScreenController=Get.put(IndexScreenController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.secoundaryColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.primaryColor,
        title:  Text('Home Screen',style: AppTextStyles.appBarTextStyle,),
        centerTitle: true,
        actions:  [
          InkWell(
          onTap: (){
              _indexScreenController.signOut();
           },
           child:const Icon(Icons.logout_outlined,color: Colors.white,
           ),
          ),
          const SizedBox(width: 10,),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableWidgets.mainButton(context, 'Fire Monitoring','images/fire.jpeg',onTap: (){
                Get.to(const FireMonitorScreen(),transition: Transition.leftToRightWithFade);
              }),
              const SizedBox(height: 20,),
              ReusableWidgets.mainButton(context,'Smoke Monitoring','images/smoke.jpeg',onTap: (){
                Get.to(const SmokeMonitorScreen(),transition: Transition.leftToRightWithFade);
              }),
              const SizedBox(height: 20,),
              ReusableWidgets.mainButton(context,'LPG Monitoring','images/lpg.jpeg',onTap: (){
                Get.to(const LPGMonitorScreen(),transition: Transition.leftToRightWithFade);
              }),
              const SizedBox(height: 20,),
              ReusableWidgets.mainButton(context,'Industrial Gases Monitoring','images/industrial.jpeg',onTap: (){
                Get.to(const IndustrialGasMonitorScreen(),transition: Transition.leftToRightWithFade);
              }),
            ],
          ),
        ),
      ),
    );
  }
}

