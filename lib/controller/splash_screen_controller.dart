import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  var isVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    // Add a delay for the fade-in effect
    Future.delayed(const Duration(milliseconds: 500), () {
      isVisible.value = true;
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
