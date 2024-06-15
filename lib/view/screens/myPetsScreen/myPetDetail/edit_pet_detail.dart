import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_pal/controllers/add_pet_controller.dart';
import 'package:pet_pal/controllers/edit_pet_controller.dart';
import 'package:pet_pal/core/constants/app_colors.dart';
import 'package:pet_pal/core/services/image_picker_service.dart';
import 'package:pet_pal/core/services/validation_service.dart';
import 'package:pet_pal/core/utils/snackbar.dart';
import 'package:pet_pal/models/pets_model.dart';
import 'package:pet_pal/view/screens/dashboard/main_screen.dart';
import 'package:pet_pal/view/widgets/common_image_view_widget.dart';
import 'package:pet_pal/view/widgets/custom_dropdown_widget.dart';
import 'package:pet_pal/view/widgets/custom_textfield.dart';
import 'package:pet_pal/view/widgets/my_button.dart';

import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/services/firebaseServices/firebase_crud.dart';
import '../../../../core/services/firebaseServices/firebase_storage_service.dart';
import '../../../../core/utils/lists.dart';
import '../../../../core/utils/utils.dart';
import '../../../widgets/text_widget.dart';


class EditPetDetailScreen extends StatefulWidget {
  final PetsModel petsModel;

  const EditPetDetailScreen({super.key, required this.petsModel});

  @override
  State<EditPetDetailScreen> createState() => _EditPetDetailScreenState();
}

class _EditPetDetailScreenState extends State<EditPetDetailScreen> {
  var controller = Get.put(EditPetController());
  GlobalKey<FormState> editPetFormKey = GlobalKey();

  late String imageUrl, gender, breed;
  TextEditingController petNameController = TextEditingController();
  TextEditingController petAgeController = TextEditingController();
  TextEditingController petAddressController = TextEditingController();
  TextEditingController petDetailController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    imageUrl = widget.petsModel.petImage;
    gender = widget.petsModel.gender;
    breed = widget.petsModel.breed;

    petNameController.text = widget.petsModel.petName;
    petAgeController.text = widget.petsModel.petAge;
    petAddressController.text = widget.petsModel.petAddress;
    petDetailController.text = widget.petsModel.petDescription;

    super.initState();
  }

  editPetDetails({required BuildContext context}) async {
    Utils.showProgressDialog(context: context);
    if (controller.imagePath.value.isNotEmpty) {
      imageUrl = await FirebaseStorageService.instance
          .uploadSingleImage(
          imgFilePath: controller.imagePath.value, storageRef: 'petImages');
    }


    await FirebaseCRUDService.instance.updateDocument(
        collectionReference: FirebaseConstants.petsCollectionReference,
        docId: widget.petsModel.petId,
        data: PetsModel(petDescription: petDetailController.text.trim(),
            petName: petNameController.text,
            petAge: petAgeController.text,
            petAddress: petAddressController.text,
            petImage: imageUrl,
            petOwnerId: widget.petsModel.petOwnerId,
            breed: breed,

            vaccinations: widget.petsModel.vaccinations,
            gender: gender, petId: widget.petsModel.petId).toMap());
    Utils.hideProgressDialog(context: context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Pet Details"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: editPetFormKey,
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
                          () =>
                      controller.imagePath.isNotEmpty
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
                          : Stack(
                        children: [
                          Center(
                            child: CommonImageView(
                              height: Get.width,
                              radius: 15,
                              url: imageUrl,
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
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  controller: petNameController,
                  validator: ValidationService.instance.emptyValidator,
                  top: 22,
                  labelText: "Enter Pet Name",
                  hintText: "Pet Name",
                ),
                CustomTextField(
                  controller: petAgeController,
                  validator: ValidationService.instance.emptyValidator,
                  top: 22,
                  keyboardType: TextInputType.number,
                  labelText: "Enter Pet Age",
                  hintText: '1',
                ),

                CustomTextField(
                  controller: petAddressController,
                  validator: ValidationService.instance.emptyValidator,
                  top: 22,
                  labelText: "Enter Address",
                  hintText: "City Name",
                ),
                CustomTextField(
                  maxLines: 3,
                  controller: petDetailController,
                  validator: ValidationService.instance.emptyValidator,
                  top: 22,
                  labelText: "Enter Pet Detail",
                  hintText: "Add Description",
                ),
                const SizedBox(
                  height: 22,
                ),
                CustomDropDown(
                    hintTextColor: gender.isEmpty
                        ? kBlackColor50Percent
                        : Colors.black,
                    hint: gender,
                    label: "Select Gender",
                    items: const ['Male', 'Female'],
                    onChanged: (value) {
                      gender = value;
                      setState(() {

                      });
                    }),

                const SizedBox(
                  height: 22,
                ),
                CustomDropDown(
                    hintTextColor: breed.isEmpty
                        ? kBlackColor50Percent
                        : Colors.black,
                    hint: breed,
                    label: "Select Breed",
                    items: dogBreeds,
                    onChanged: (value) {
                      breed = value;
                      setState(() {

                      });
                    }),

                MyButton(
                  mBottom: 20,
                    mTop: 50,
                    onTap: () async {
                      if (editPetFormKey.currentState!.validate()) {
                        await editPetDetails(context: context);
                        CustomSnackBars.instance.showCustomSuccessSnackBar(message: "Details Updated Successfully" );
                        Get.close(2);
                      }
                    },
                    buttonText: "Edit Pet"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}