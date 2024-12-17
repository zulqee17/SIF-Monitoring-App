

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/utilities.dart';

class ResetPasswordScreenController extends GetxController{
  RxBool isLoading=false.obs;

  final emailController=TextEditingController();

  void sendResetLink(){
    final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    isLoading.value=true;
    try{
      isLoading.value=true;
      firebaseAuth.sendPasswordResetEmail(
          email: emailController.value.text,
      ).then((value){
        isLoading.value=false;
        Utilities.toastMessage('password reset link sent to email, go check your email', Colors.green);
        Get.back();
      }).onError((error,stackTrace){
        isLoading.value=false;
        Utilities.toastMessage(error.toString(), Colors.red);
      });
    }catch(e){
      isLoading.value=false;
      throw Exception("reset pass link error: ${e.toString()}");
    }
    emailController.clear();
  }
}