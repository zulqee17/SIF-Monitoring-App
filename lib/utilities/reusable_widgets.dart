import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'app_text_styles.dart';
import 'colors.dart';

class ReusableWidgets {
  static Widget mainButton(BuildContext context, String title, String imagePath,
      {required VoidCallback? onTap}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Center(
        child: Container(
          height: height * .3,
          width: width * .9,
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black
                      .withOpacity(0.5), // Adjust opacity here (0.0 to 1.0)
                  BlendMode.darken, // Blending mode for applying opacity
                ),
                fit: BoxFit.fill,
                image: AssetImage(imagePath)),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.5), // Shadow color with opacity
                spreadRadius: 4, // How much the shadow spreads
                blurRadius: 7, // How much the shadow blurs
                offset: const Offset(
                    0, 3), // Changes the position of the shadow (x, y)
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.indexButtonTextStyle,
            ),
          ),
        ),
      ),
    );
  }

  static Widget authTextFieldHeading(
      BuildContext context, IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey.shade500,
          size: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .01,
        ),
        Text(title, style: AppTextStyles.authViewTextFieldHeadingTextStyle)
      ],
    );
  }

  static Widget authReusableButton(String title,bool isLoading, {VoidCallback? onPress}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoading?const CircularProgressIndicator(color: Colors.white,):Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
          ),
        ),
      ),
    );
  }

  static Widget authLoginSignup(String titleOne, String titleTwo,
      {required VoidCallback onPress}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(titleOne),
        const SizedBox(
          width: 3,
        ),
        GestureDetector(
            onTap: onPress,
            child: Text(
              titleTwo,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: AppColors.buttonColor),
            ))
      ],
    );
  }

  static Widget headingText(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.blue.shade900,
          fontSize: 25,
          fontWeight: FontWeight.bold),
    );
  }

  static Widget digitalValueContainer(
      BuildContext context, String title, int value) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .09,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 25,
                  color: AppColors.secoundaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              value.toString(),
              style: TextStyle(
                  fontSize: 25,
                  color: AppColors.secoundaryColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            )
          ],
        ),
      ),
    );
  }

  static Widget messageContainer(
      BuildContext context, String title, int value) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .2,
      width: double.infinity,
      decoration: BoxDecoration(
          color: value<400?Colors.green.shade600:Colors.red,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
                child: Text(
                  value<400?'$title Values are normal so, No worries...':'$title value is exceeded from safe limit',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )

      ),
    );
  }

  static Widget fireMessageContainer(
      BuildContext context, String title, int value) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .2,
      width: double.infinity,
      decoration: BoxDecoration(
          color: value==0?Colors.green.shade600:Colors.red,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: Text(
              value==0?'$title Values are normal so, No worries...':'$title value is exceeded from safe limit',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 30.1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )

      ),
    );
  }


  static Widget moniteringGuage(double value) {
    return Card(
      color: AppColors.primaryColor,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        axes: <RadialAxis>[
          RadialAxis(
            canScaleToFit: true,
            showLastLabel: true,
            minimum: 0,
            maximum: 1000,
            ranges: [
              GaugeRange(
                startValue: 0,
                endValue: 250,
                color: Colors.green,
              ),
              GaugeRange(
                  startValue: 250, endValue: 500, color: Colors.yellow),
              GaugeRange(
                startValue: 500,
                endValue: 750,
                color: Colors.orange,
              ),
              GaugeRange(
                startValue: 750,
                endValue: 1000,
                color: Colors.red,
              ),
            ],
            pointers: [
              NeedlePointer(
                needleColor: Colors.white,
                value: value,
                enableAnimation: true, // Enable animation
                animationType: AnimationType
                    .linear, // Choose animation type (ease, bounce, etc.)
                animationDuration: 500,
              ),
              // Real-time fire value
            ],
          ),
        ],
      ),
    );
  }
}
