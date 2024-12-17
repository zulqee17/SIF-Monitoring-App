

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/utilities.dart';
import '../views/auth_views/login_screen.dart';

class IndexScreenController extends GetxController{

  void signOut(){
    final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    try{
      firebaseAuth.signOut().then((value){
        Get.off(const LoginScreen(),transition: Transition.leftToRightWithFade);
        Utilities.toastMessage('logged out successfully', Colors.green);
      }).onError((error,stackTrace){
        Utilities.toastMessage(error.toString(), Colors.red);
      });
    }catch(e){
      throw Exception('sign out error : ${e.toString()}');
    }
  }
}