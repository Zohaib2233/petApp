import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pet_pal/controllers/profileController/edit_profile_controller.dart';
import 'package:pet_pal/core/global/variables.dart';
import 'package:pet_pal/core/utils/app_strings.dart';
import 'package:pet_pal/view/widgets/common_image_view_widget.dart';



import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

import '../../../core/services/validation_service.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/intel_phone_field_widget.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_widget.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(EditProfileController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
                  () => controller.profilePath.value == ''
                  ? ProfileImage(
                profileImg: userModelGlobal.value.profileUrl,
                userName: "Change profile photo",
                onProfileChange: () {
                  controller.buildOpenImagePickerBottomSheet(
                      context: context,
                      cameraTap: () async {
                        Get.back();
                        await controller.pickImageFromCamera();
                      },
                      galleryTap: () async {
                        Get.back();
                        await controller.pickImageFromGallery();
                      });
                },
              )
                  : ProfileImage(
                fileImage: controller.profilePath.value,
                userName: "Change profile photo",
                onProfileChange: () {
                  controller.buildOpenImagePickerBottomSheet(
                      context: context,
                      cameraTap: controller.pickImageFromCamera(),
                      galleryTap: controller.pickImageFromGallery());
                },
              ),
            ),



            Padding(
              padding: AppSizes.HORIZONTAL,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  CustomTextField(
                    top: 22,
                    labelText: "Name",
                    hintText: "Your Name",
                    controller: controller.nameController,
                    validator: ValidationService.instance.emptyValidator,
                  ),

                  CustomTextField(
                    top: 22,
                    labelText: "Username",
                    hintText: "username",
                    controller: controller.userNameController,
                    validator: ValidationService.instance.emptyValidator,
                  ),
                  // CustomTextField(
                  //   top: 12,
                  //   labelText: "Email address",
                  //   hintText: "youremail@gmail.com",
                  //   controller: controller.emailController,
                  //   // validator: ValidationService.instance.emailValidator,
                  // ),
                  // Phone Number

                  IntlPhoneFieldWidget(
                    controller: controller.phoneNumberController,
                    onSubmitted: (value) {
                      print("controller.phoneNumberController = ${controller.phoneNumberController.text}");
                      // controller.combinePhoneNumber(value);
                      print("Value ${value.completeNumber}");
                      controller.combinePhoneNumber.value =
                          value.completeNumber;
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      await controller.selectDob(context);
                    },
                    child: CustomTextField(
                      controller: controller.dobController,
                      enabled: false,
                      top: 0,
                      labelText: "Date of birth",

                      hintText: "dd/mm/yy",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: AppSizes.HORIZONTAL,
              child: Row(
                children: [
                  Expanded(
                    child: MyButton(
                              onTap: () {
                                controller.updateProfile(context: context);
                              },
                              buttonText: "Done"),

                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _LebelTextFieldCustom extends StatelessWidget {
  final String? label;
  final double cPL;
  TextEditingController? controller = TextEditingController();
  _LebelTextFieldCustom({super.key, this.label, this.cPL = 0, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        cursorHeight: 15,
        cursorWidth: 1,
        controller: controller,
        // controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: cPL),
          label: MyText(
            text: '$label',
            size: 14,
            weight: FontWeight.w400,
            color: kGreyColor1,
          ),
          hintStyle:
              TextStyle(fontSize: 13, color: kGreyColor1.withOpacity(0.5)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kSecondaryColor),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kGreyColor1.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String? profileImg, userName, fileImage;
  final VoidCallback? onProfileChange;
  const ProfileImage(
      {super.key,
      this.profileImg,
      this.userName,
      this.fileImage,
      this.onProfileChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      padding: EdgeInsets.only(top: 60),
      width: double.maxFinite,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bk_decoration_png_img.png'),
              fit: BoxFit.fill)),
      child: Column(
        children: [
          fileImage == null
              ? CommonImageView(
           url: profileImg,
            height: 120,

          )
              : CommonImageView(
            file: File(fileImage!),
            width: 120,
            fit: BoxFit.cover,
            height: 120,

          ),
          GestureDetector(
            onTap: onProfileChange,
            child: MyText(
              paddingTop: 10,
              text: "$userName",
              size: 12,
              weight: FontWeight.w400,
              color: kSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
