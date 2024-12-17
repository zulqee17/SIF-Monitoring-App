

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/auth_views/login_screen.dart';
import '../views/index_screen/index_monitor_screen.dart';

class SplashServices{

  static void islogIn(BuildContext context){
    final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    try{
      if(firebaseAuth.currentUser!=null){
        Timer(const Duration(seconds: 3),(){
          Get.off(const IndexMonitorScreen(),transition: Transition.leftToRightWithFade);
        });
      }else{
        Timer(const Duration(seconds: 3),(){
          Get.off(const LoginScreen(),transition: Transition.leftToRightWithFade);
        });
      }
    }catch(e){
      throw Exception('splash service error: ${e.toString()}');
    }

  }
}