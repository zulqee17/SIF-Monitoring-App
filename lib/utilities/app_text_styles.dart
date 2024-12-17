import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTextStyles {

  static TextStyle indexButtonTextStyle =  GoogleFonts.poppins(
      fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white);

  static TextStyle appBarTextStyle= GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w700);

  static TextStyle authViewHeadingTextStyle=GoogleFonts.poppins(fontSize: 30,fontWeight: FontWeight.w600)  ;

  static TextStyle authViewTitleHeadingTextStyle= GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600,color: AppColors.buttonColor);

  static TextStyle authViewTextFieldHeadingTextStyle= GoogleFonts.poppins(color: Colors.grey.shade500,fontWeight: FontWeight.w600);


}
// TextStyle(fontSize: 30,fontWeight: FontWeight.w600)