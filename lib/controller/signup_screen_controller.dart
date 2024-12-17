
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/utilities.dart';

class SignupScreenController extends GetxController{
  RxBool isPassVisible=false.obs;
  RxBool isConfPassVisible=false.obs;
  RxBool isLoading=false.obs;


  final emailController=TextEditingController();
  final passController=TextEditingController();
  final confPassController=TextEditingController();

  void toggleVisible(){
    isPassVisible.value=!isPassVisible.value;
  }
  void confToggleVisible(){
    isConfPassVisible.value=!isConfPassVisible.value;
  }

  void signUp(){
    isLoading.value=true;
    final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    try{
      isLoading.value=true;
      firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.value.text,
          password: passController.value.text
      ).then((value){
        isLoading.value=false;
        Utilities.toastMessage('signed up successfully', Colors.green);
      }).onError((error,stackTrace){
        isLoading.value=false;
        Utilities.toastMessage(error.toString(), Colors.red);
      });
    }catch(e){
      isLoading.value=false;
      throw Exception("sign up error: ${e.toString()}");
    }
  }
}