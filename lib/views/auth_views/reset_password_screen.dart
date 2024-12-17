import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../controller/reset_password_screen_controller.dart';
import '../../utilities/app_text_styles.dart';
import '../../utilities/reusable_widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _resetPassController=Get.put(ResetPasswordScreenController());
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25,right: 25,top: 40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                        "Reset Password",
                        style: AppTextStyles.authViewHeadingTextStyle,
                      )),
                  SizedBox(
                    height: height * .15,
                  ),
                  Text("Confirm your email and we'll send the password reset link", style: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.bold,fontSize: 18)),
                  SizedBox(
                    height: height * .05,
                  ),
                  ReusableWidgets.authTextFieldHeading(context, Icons.person_2_outlined, 'Enter your email'),
                  SizedBox(
                    height: height * .01,
                  ),
                  TextFormField(
                    controller: _resetPassController.emailController,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: 'email',
                      // hintStyle: TextStyle(color: Colors.grey.shade500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.grey.shade500, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade500,
                          )),
                    ),
                    validator: (value) {
                      const emailPattern =
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
                      if (value!.isEmpty) {
                        return 'enter email';
                      } else if (!RegExp(emailPattern).hasMatch(value)) {
                        return 'enter valid email';
                      } else {
                        null;
                      }
                    },
                  ),
                  SizedBox(height: height*.04,),
                  Obx((){
                    return ReusableWidgets.authReusableButton(
                        onPress:(){
                          if(_formKey.currentState!.validate()){
                            _resetPassController.sendResetLink();
                          }
                        },
                        'Reset Password',
                        _resetPassController.isLoading.value
                    );
                  }),
                  SizedBox(height: height*.07,),
                  const Center(child: Text("Please check your email",style: TextStyle(fontWeight: FontWeight.bold),))
                 
                ],
              ),
            ),
          ),
        )
    );
  }
}
