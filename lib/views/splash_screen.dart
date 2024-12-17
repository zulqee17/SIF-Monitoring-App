import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/splash_screen_controller.dart';
import '../services/splash_services.dart';

class SFISplashScreen extends StatefulWidget {
  const SFISplashScreen({super.key});

  @override
  State<SFISplashScreen> createState() => _SFISplashScreenState();
}

class _SFISplashScreenState extends State<SFISplashScreen> {

  @override
  void initState() {
    super.initState();
    SplashServices.islogIn(context);
  }

  @override
  Widget build(BuildContext context) {
    final SplashScreenController splashController =
        Get.put(SplashScreenController());

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Obx(
              () => ScaleTransition(
                scale: CurvedAnimation(
                  parent: splashController.animationController,
                  curve: Curves.easeInOut,
                ), // Apply scale transition
                child: AnimatedOpacity(
                  opacity: splashController.isVisible.value ? 1.0 : 0.0, // Fade-in animation
                  duration: const Duration(seconds: 1),
                  child: SizedBox(
                    height: height * 0.35,
                    width: width * 0.72,
                    child: Center(child: Image.asset('images/logo.png')),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          ShaderMask(
            shaderCallback: (bounds) =>const LinearGradient(
              colors: [Colors.blue, Colors.black87],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(
                Rect.fromLTWH(0.0, 0.0, bounds.width, bounds.height)),
            child: const Text(
              'SMOKE, FIRE &\n INDUSTRIAL GAS \n MONITORING SYSTEM',
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
