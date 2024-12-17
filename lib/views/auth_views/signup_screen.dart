import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/signup_screen_controller.dart';
import '../../utilities/app_text_styles.dart';
import '../../utilities/reusable_widgets.dart';
import '../../utilities/utilities.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupScreenController=Get.put(SignupScreenController());

  FocusNode email = FocusNode();
  FocusNode password = FocusNode();
  FocusNode confPassword = FocusNode();

  final _formKey=GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
    confPassword.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25,right: 25,top: 100),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                        "Create Account",
                        style: AppTextStyles.authViewHeadingTextStyle,
                      )),
                  SizedBox(
                    height: height * .08,
                  ),
                  Text("Sign Up", style: AppTextStyles.authViewTitleHeadingTextStyle),
                  SizedBox(
                    height: height * .05,
                  ),
                  ReusableWidgets.authTextFieldHeading(context, Icons.person_2_outlined, 'Enter your email'),
                  SizedBox(
                    height: height * .01,
                  ),
                  TextFormField(
                    controller: _signupScreenController.emailController,
                    cursorColor: Colors.grey,
                    focusNode: email,
                    onFieldSubmitted: (value) {
                      Utilities.focusChange(context, email, password);
                    },
                    decoration: InputDecoration(
                      hintText: 'email',
                      // hintStyle: TextStyle(color: Colors.grey.shade500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2)),
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
                  SizedBox(
                    height: height * .02,
                  ),
                  ReusableWidgets.authTextFieldHeading(context, Icons.lock_outline, 'Enter password'),
                  SizedBox(
                    height: height * .01,
                  ),
                  TextFormField(
                    controller: _signupScreenController.passController,
                    obscuringCharacter: '*',
                    obscureText: _signupScreenController.isPassVisible.value,
                    cursorColor: Colors.grey,
                    focusNode: password,
                    onFieldSubmitted: (value) {
                      Utilities.focusChange(context, password, confPassword);
                    },
                    decoration: InputDecoration(
                      hintText: 'password',
                      // hintStyle: TextStyle(color: Colors.grey.shade500),
                      suffixIcon:Obx((){
                        return InkWell(
                            onTap: (){
                             _signupScreenController.isPassVisible();
                            },
                            child: _signupScreenController.isPassVisible.value?const Icon(Icons.visibility_off_outlined):const Icon(Icons.visibility_outlined));
                      }
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2)),
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
                    validator: (value){
                      if(value!.isEmpty){
                        return 'enter password';
                      }else{
                        null;
                      }
                    },
                  ),
                  SizedBox(height: height * .02,),
                  ReusableWidgets.authTextFieldHeading(context, Icons.lock_outline, 'Confirm password'),
                  SizedBox(
                    height: height * .01,
                  ),
                  TextFormField(
                    controller: _signupScreenController.confPassController,
                    obscuringCharacter: '*',
                    obscureText: _signupScreenController.isConfPassVisible.value,
                    cursorColor: Colors.grey,
                    focusNode: confPassword,
                    onFieldSubmitted: (value) {
                      Utilities.focusChange(context, confPassword, confPassword);
                    },
                    decoration: InputDecoration(
                      hintText: 'confirm password',
                      // hintStyle: TextStyle(color: Colors.grey.shade500),
                      suffixIcon:Obx((){
                        return InkWell(
                            onTap: (){
                              _signupScreenController.confToggleVisible();
                            },
                            child: _signupScreenController.isConfPassVisible.value?const Icon(Icons.visibility_off_outlined):const Icon(Icons.visibility_outlined));
                      }),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2)),
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
                    validator: (value){
                      if(value!.isEmpty){
                        return 'enter confirm password';
                      }else if(value!=_signupScreenController.passController.text){
                        return 'passwords do not match';
                      }else{
                        null;
                      }
                    },
                  ),
                  SizedBox(height: height*.04,),
                  Obx((){
                    return ReusableWidgets.authReusableButton(
                        onPress:(){
                          if(_formKey.currentState!.validate()){
                            _signupScreenController.signUp();
                          }
                        },
                        'Sign Up',
                        _signupScreenController.isLoading.value
                    );
                  }),
                  SizedBox(height: height*.05,),
                  ReusableWidgets.authLoginSignup(
                      onPress: (){
                        Get.back();
                      },
                      'Already a User?','Login'),

                ],
              ),
            ),
          ),
        )
    );
  }
}
