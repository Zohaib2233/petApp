import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pet_pal/controllers/authControllers/signup_controller.dart';
import 'package:pet_pal/view/screens/authScreens/login_screen.dart';
import 'package:pet_pal/view/widgets/common_image_view_widget.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/validation_service.dart';
import '../../../core/utils/snackbar.dart';
import '../../widgets/checkbox_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/intel_phone_field_widget.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<SignupController>();
    GlobalKey<FormState> signupFormKey = GlobalKey();
    ///Todo:
    // var controller = Get.find<SignupController>();

    return Scaffold(
      // appBar: auth_appbar(haveBackIcon: false),
      body: Form(
        key: signupFormKey,
        child: Padding(
          padding: AppSizes.DEFAULT,
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              CommonImageView(
                //imagePath: 'assets/images/logo.png',
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
                text: "Sign-up today",
                size:28,
                weight: FontWeight.w600,
              ),
              MyText(
                textAlign: TextAlign.center,
                paddingTop: 7,
                text: "Provide us your credentials to start journey",
                size: 12,
                weight: FontWeight.w600,
              ),
              CustomTextField(

                top: 22,
                labelText: "Name",
                hintText: "yourname",
                controller: controller.nameController,
                validator: ValidationService.instance.emptyValidator,
              ),
              CustomTextField(
                top: 22,
                labelText: "UserName",
                hintText: "username",
                controller: controller.usernameController,
                validator: ValidationService.instance.userNameValidator,
              ),
              CustomTextField(
                top: 12,
                labelText: "Email address",
                hintText: "youremail@gmail.com",
                controller: controller.emailController,
                validator: ValidationService.instance.emailValidator,
              ),
              // Phone Number

              IntlPhoneFieldWidget(
                validator: (value) {
                  print(value);
                  return ValidationService.instance.emptyValidator(value);
                },
                // controller: controller.phoneController,
                onSubmitted: (value) {
                  ///Todo:
                  controller.combinePhoneNumber(value);
                  print("Value ${value.completeNumber}");
                },
              ),
              Obx(()=>GestureDetector(
                  onTap: () async {
                    ///Todo:
                    await controller.selectDob(context);
                  },
                  child: CustomTextField(
                    enabled: false,
                    top: 0,
                    labelText: "Date of birth",
                    controller: controller.dobController.value,
                    validator: ValidationService.instance.emptyValidator,
                    hintText: "dd/mm/yy",
                  ),
                ),
              ),
              CustomTextField(
                maxLines: 3,
                top: 12,
                labelText: "Address",
                controller: controller.addressController,
                validator: ValidationService.instance.emptyValidator,
                hintText: "Enter Address",

              ),
              CustomTextField(
                obscureText: true,
                top: 12,
                labelText: "Password",
                controller: controller.passwordController,
                validator: ValidationService.instance.validatePassword,
                hintText: "************",

              ),
              CustomTextField(
                  obscureText: true,
                  top: 12,
                  labelText: "Re-enter password",
                  hintText: "************",
                  controller: controller.againPasswordController,
                ///
                  validator: (value) {
                    return ValidationService.instance.validateMatchPassword(
                        controller.againPasswordController.text,
                        controller.passwordController.text);
                  }
                  ),
              SizedBox(height: 11),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       width: 20,
              //       child: Transform.scale(
              //           scale: 0.9,
              //           child:  CheckBoxWidget(
              //             onChanged: (x) {
              //               print(x);
              //
              //           },
              //                   // isChecked: controller.isCheck.value,
              //                  )
              //           // Obx(
              //           //       () => CheckBoxWidget(
              //           //       isChecked: controller.isCheck.value,
              //           //       onChanged: (value) {
              //           //         print(value);
              //           //         controller.isCheck.value = value!;
              //           //         print(controller.isCheck.value);
              //           //       }),
              //           // )
              //       ),
              //     ),
              //     SizedBox(width: 10),
              //     MyText(
              //       text:
              //       "I agree to the all Terms of Service and Privacy Policy",
              //       size: 10,
              //       weight: FontWeight.w600,
              //     ),
              //   ],
              // ),
              ///Todo


               MyButton(

                    onTap: () async {
                      if(signupFormKey.currentState!.validate()){
                        controller.registerUser(context);
                      }

                    },
                    mTop: 32,
                    mBottom: 16,
                    buttonText: "Sign up"),

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
                      Get.to(()=>const LoginScreen());
                    },
                    text: "Sign in",
                    size: 12,
                    weight: FontWeight.w600,
                    color: kSecondaryColor,
                  ),
                ],
              ),
              // MyText(
              //   textAlign: TextAlign.center,
              //   paddingTop: 22,
              //   paddingBottom: 16,
              //   text: "or Sign in with",
              //   size: 12,
              //   weight: FontWeight.w500,
              // ),
              // MyButton(
              //   onTap: () {},
              //   buttonText: "Sign in with Google",
              //   haveSvg: true,
              //   svgIcon: Assets.imagesGoogleIcon,
              //   backgroundColor: kTransperentColor,
              //   fontColor: kBlackColor1,
              //   outlineColor: kGreyColor3,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}