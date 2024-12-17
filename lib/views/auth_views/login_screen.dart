import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sif_monitoring/views/auth_views/reset_password_screen.dart';
import 'package:sif_monitoring/views/auth_views/signup_screen.dart';
import '../../controller/login_screen_controller.dart';
import '../../utilities/app_text_styles.dart';
import '../../utilities/colors.dart';
import '../../utilities/reusable_widgets.dart';
import '../../utilities/utilities.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginScreenController=Get.put(LoginScreenController());

  FocusNode email = FocusNode();
  FocusNode password = FocusNode();

  final _formKey=GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25,right: 25,top: 125),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  "Welcome Back",
                  style: AppTextStyles.authViewHeadingTextStyle,
                )),
                SizedBox(
                  height: height * .08,
                ),
                Text("Login", style: AppTextStyles.authViewTitleHeadingTextStyle),
                SizedBox(
                  height: height * .05,
                ),
                ReusableWidgets.authTextFieldHeading(context, Icons.person_2_outlined, 'Enter your email'),
                SizedBox(
                  height: height * .01,
                ),
                TextFormField(
            cursorColor: Colors.grey,
            focusNode: email,
            controller: _loginScreenController.emailController,
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
                Obx((){
                  return TextFormField(
                    controller: _loginScreenController.passController,
                    obscuringCharacter: '*',
                    obscureText: _loginScreenController.isVisible.value,
                    cursorColor: Colors.grey,
                    focusNode: password,
                    onFieldSubmitted: (value) {
                      Utilities.focusChange(context, password, password);
                    },
                    decoration: InputDecoration(
                      hintText: 'password',
                      // hintStyle: TextStyle(color: Colors.grey.shade500),
                      suffixIcon: InkWell(
                          onTap: _loginScreenController.toggleVisible,
                          child: Icon(_loginScreenController.isVisible.value?Icons.visibility_off_outlined:Icons.visibility)),
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
                  );
                }),
                SizedBox(height: height*.04,),
                Center(
                  child: InkWell(
                    onTap: (){
                      Get.to(const ResetPasswordScreen());
                    },
                    child: Text("Forgot Password?",style: TextStyle(color: AppColors.buttonColor,fontWeight: FontWeight.bold),)),),
                SizedBox(height: height*.04,),
                Obx((){
                  return ReusableWidgets.authReusableButton(
                      onPress:(){
                        if(_formKey.currentState!.validate()){
                          _loginScreenController.logIn();
                        }
                      },
                      'Login',
                      _loginScreenController.isLoading.value
                  );
                }),
                SizedBox(height: height*.05,),
                ReusableWidgets.authLoginSignup(
                    onPress: (){
                      Get.to(const SignupScreen());
                    },
                    'Are you a new User?',
                    'Sign up'),
              ],
            ),
          ),
        ),
      )
    );
  }
}
