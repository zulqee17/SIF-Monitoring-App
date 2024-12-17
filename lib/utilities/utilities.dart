

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Utilities{
  static void focusChange(BuildContext context,FocusNode current,FocusNode next){
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }
  static void toastMessage(String message,Color color){
    Fluttertoast.showToast(
        msg: message,
      backgroundColor: color,
      textColor: Colors.white
    );
  }
}