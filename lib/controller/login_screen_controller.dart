
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../utilities/utilities.dart';
import '../views/index_screen/index_monitor_screen.dart';

class LoginScreenController extends GetxController{
  RxBool isVisible=false.obs;
  RxBool isLoading=false.obs;


  final emailController=TextEditingController();
  final passController=TextEditingController();

  void toggleVisible(){
    isVisible.value=!isVisible.value;
  }

  void logIn(){
    final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    isLoading.value=true;
    try{
      isLoading.value=true;
      firebaseAuth.signInWithEmailAndPassword(
          email: emailController.value.text,
          password: passController.value.text
      ).then((value){
        isLoading.value=false;
        Utilities.toastMessage('log in successfully', Colors.green);
        Get.off(const IndexMonitorScreen(),transition: Transition.leftToRightWithFade);
      }).onError((error,stackTrack){
        isLoading.value=false;
        Utilities.toastMessage(error.toString(), Colors.red);
      });
    }catch(e){
      isLoading.value=false;
      throw Exception("log In error: ${e.toString()}");
    }
  }
}