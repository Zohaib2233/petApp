import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_pal/controllers/add_pet_controller.dart';
import 'package:pet_pal/core/constants/app_colors.dart';
import 'package:pet_pal/core/services/image_picker_service.dart';
import 'package:pet_pal/core/services/validation_service.dart';
import 'package:pet_pal/view/screens/dashboard/main_screen.dart';
import 'package:pet_pal/view/widgets/common_image_view_widget.dart';
import 'package:pet_pal/view/widgets/custom_dropdown_widget.dart';
import 'package:pet_pal/view/widgets/custom_textfield.dart';
import 'package:pet_pal/view/widgets/my_button.dart';

import '../../../core/utils/lists.dart';
import '../../widgets/text_widget.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  var controller = Get.find<AddPetController>();
  GlobalKey<FormState> petFormKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Pet Details"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: petFormKey,
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    ImagePickerService.instance.openProfilePickerBottomSheet(
                        context: context,
                        onCameraPick: () async {
                          await controller.selectImageFromCamera();
                          Get.back();
                        },
                        onGalleryPick: () async {
                          await controller.selectImageFromGallery();
                          Get.back();
                        });
                  },
                  child: Container(
                    height: Get.height * 0.3,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: const Color(0xffF0F0F0),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Obx(
                      () => controller.imagePath.isNotEmpty
                          ? Stack(
                              children: [
                                Center(
                                  child: CommonImageView(
                                    height: Get.width,
                                    radius: 15,
                                    file: File(controller.imagePath.value),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: GestureDetector(
                                      onTap: () {
                                        ImagePickerService.instance
                                            .openProfilePickerBottomSheet(
                                                context: context,
                                                onCameraPick: () async {
                                                  await controller
                                                      .selectImageFromCamera();
                                                  Get.back();
                                                },
                                                onGalleryPick: () async {
                                                  await controller
                                                      .selectImageFromGallery();
                                                  Get.back();
                                                });
                                      },
                                      child: const Icon(
                                        Icons.change_circle_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.image_outlined,
                                  size: 55,
                                ),
                                TextWidget(
                                    text: "Upload image",
                                    size: 22,
                                    color: const Color(0xff9E9E9E),
                                    fontWeight: FontWeight.w600),
                              ],
                            ),
                    ),
                  ),
                ),
                CustomTextField(
                  controller: controller.petNameController,
                  validator: ValidationService.instance.emptyValidator,
                  top: 22,
                  labelText: "Enter Pet Name",
                  hintText: "Pet Name",
                ),
                CustomTextField(
                  controller: controller.petAgeController,
                  validator: ValidationService.instance.emptyValidator,
                  top: 22,
                  keyboardType: TextInputType.number,
                  labelText: "Enter Pet Age",
                  hintText: '1',
                ),

                CustomTextField(
                  controller: controller.petAddressController,
                  validator: ValidationService.instance.emptyValidator,
                  top: 22,
                  labelText: "Enter Address",
                  hintText: "City Name",
                ),
                CustomTextField(
                  maxLines: 3,
                  controller: controller.petDescriptionController,
                  validator: ValidationService.instance.emptyValidator,
                  top: 22,
                  labelText: "Enter Pet Detail",
                  hintText: "Add Description",
                ),
                const SizedBox(
                  height: 22,
                ),
                Obx(
                  () => CustomDropDown(
                      hintTextColor: controller.gender.isEmpty
                          ? kBlackColor50Percent
                          : Colors.black,
                      hint: controller.gender.isEmpty
                          ? 'Male'
                          : controller.gender.value,
                      label: "Select Gender",
                      items: const ['Male', 'Female'],
                      onChanged: (value) {
                        controller.gender.value = value;
                      }),
                ),
                const SizedBox(
                  height: 22,
                ),
                Obx(
                  () => CustomDropDown(
                      hintTextColor: controller.breed.isEmpty
                          ? kBlackColor50Percent
                          : Colors.black,
                      hint: controller.breed.isEmpty
                          ? ''
                          : controller.breed.value,
                      label: "Select Breed",
                      items: dogBreeds,
                      onChanged: (value) {
                        controller.breed.value = value;
                      }),
                ),
                MyButton(
                    mTop: 50,
                    onTap: () async {
                      if (petFormKey.currentState!.validate()) {
                        await controller.addPetDetails(context: context).then(
                            (value) => Get.offAll(()=>const MainScreen()));
                      }
                    },
                    buttonText: "Add Pet"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
