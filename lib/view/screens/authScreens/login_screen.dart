import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pet_pal/view/screens/authScreens/otp.dart';
import 'package:pet_pal/view/screens/authScreens/register_screen.dart';

import '../../../controllers/authControllers/login_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/validation_service.dart';
import '../../widgets/checkbox_widget.dart';
import '../../widgets/common_image_view_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_widget.dart';
import '../dashboard/main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();
    var controller = Get.find<LoginController>();
    return Scaffold(
      // appBar: auth_appbar(haveBackIcon: false),
      body: Stack(
        children: [
          Form(
            key: loginFormKey,
            child: Padding(
              padding: AppSizes.DEFAULT,
              child: ListView(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 25,),
                  CommonImageView(
                    // imagePath: 'assets/images/logo.png',
                    imagePath: 'assets/images/pet_pal_logo.png',
                    height: 150,
                    width: 150,
                    fit: BoxFit.scaleDown,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyText(
                    textAlign: TextAlign.center,
                    text: "Welcome back!",
                    size: 28,
                    weight: FontWeight.w600,
                  ),
                  MyText(
                    textAlign: TextAlign.center,
                    paddingTop: 7,
                    text: "Glad to see you again. Sign in with us.",
                    size: 12,
                    weight: FontWeight.w600,
                  ),
                  CustomTextField(
                    top: 22,
                    labelText: "Email address",
                    hintText: "youremail@gmail.com",
                    controller: controller.emailController,
                    validator: ValidationService.instance.emailValidator,
                  ),
                  CustomTextField(
                    top: 12,
                    labelText: "Password",
                    hintText: "**********",
                    validator: ValidationService.instance.validatePassword,
                    controller: controller.passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 12),
                  // Check Box missing
                  //-------------------------------
                  Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 20,
                        child: Transform.scale(
                            scale: 0.9,
                          child: Obx(()=>CheckBoxWidget(
                                isChecked: controller.isChecked.value,
                                onChanged: (value) {
                                  controller.changeCheckValue(value!);
                                }),
                          ),

                        ),
                      ),
                      MyText(
                        paddingLeft: 10,
                        text: "Remember me",
                        size: 10,
                        weight: FontWeight.w600,
                      ),
                      Spacer(),
                      MyText(
                        onTap: () {
                          /// Todo
                          // Get.to(ForgotPassword());
                        },
                        text: "Forgot Password?",
                        size: 10,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),

                  Obx(()=>MyButton(
                      isLoading: controller.isLoading.value,
                        onTap: () async {
                          // Get.to(()=>const OtpScreen());
                          if (loginFormKey.currentState!.validate()) {
                            await controller.loginWithEmailPassword(context);
                          }
                        },
                        mTop: 32,
                        mBottom: 16,
                        buttonText: "Log in"),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        paddingRight: 10,
                        text: "Don’t have an Account?",
                        size: 12,
                        weight: FontWeight.w400,
                      ),
                      MyText(
                        onTap: () {
                          Get.to(()=>RegisterScreen());
                          // Get.to(Register());
                        },
                        text: "Sign up",
                        size: 12,
                        weight: FontWeight.w600,
                        color: kSecondaryColor,
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
          ///Todo
          // Obx(() => controller.isLoading.value
          //     ? Container(
          //   height: Get.height,
          //   width: Get.width,
          //   color: Colors.grey.withOpacity(0.8),
          //   child: Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // )
          //     : Container())
        ],
      ),
    );
  }
}