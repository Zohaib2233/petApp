import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_pal/core/constants/app_colors.dart';
import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/core/global/variables.dart';
import 'package:pet_pal/core/services/firebaseServices/firebase_crud.dart';
import 'package:pet_pal/core/services/firebaseServices/firebase_storage_service.dart';
import 'package:pet_pal/core/utils/snackbar.dart';
import 'package:pet_pal/core/utils/utils.dart';
import 'package:pet_pal/models/pets_model.dart';

import '../core/services/image_picker_service.dart';

class AddPetController extends GetxController {
  RxString imagePath = ''.obs;
  RxString gender = ''.obs;
  RxString breed = ''.obs;

  TextEditingController petNameController = TextEditingController();
  TextEditingController petAgeController = TextEditingController();
  TextEditingController petAddressController = TextEditingController();
  TextEditingController petDescriptionController = TextEditingController();

  selectImageFromCamera() async {
    XFile? image = await ImagePickerService.instance.pickImageFromCamera();

    if (image != null) {
      imagePath.value = image.path;
    }
  }

  selectImageFromGallery() async {
    XFile? image =
        await ImagePickerService.instance.pickSingleImageFromGallery();

    if (image != null) {
      imagePath.value = image.path;
    }
  }

  Future addPetDetails({required BuildContext context}) async {
    if (imagePath.isEmpty) {
      CustomSnackBars.instance.showCustomSuccessSnackBar(
          message: "Please Select Image", color: kLightRedColor);
    } else if (gender.isEmpty) {
      CustomSnackBars.instance.showCustomSuccessSnackBar(
          message: "Please Select Gender", color: kLightRedColor);
    } else if (breed.isEmpty) {
      CustomSnackBars.instance.showCustomSuccessSnackBar(
          message: "Please Select Breed", color: kLightRedColor);
    } else {
      Utils.showProgressDialog(context: context);
      String downloadUrl = await FirebaseStorageService.instance
          .uploadSingleImage(
              imgFilePath: imagePath.value, storageRef: 'petImages');
      if (downloadUrl != '') {
        String docId = FirebaseCRUDService.instance.getCollectionId(
            collectionReference: FirebaseConstants.firestore
                .collection(FirebaseConstants.petsCollection));
        print("Doc Id= $docId");

        await FirebaseCRUDService.instance.createDocument(
            collectionReference: FirebaseConstants.firestore
                .collection(FirebaseConstants.petsCollection),
            docId: docId,
            data: PetsModel(
              petAddress: petAddressController.text.trim(),
                    petImage: downloadUrl,
                    petId: docId,
                    petName: petNameController.text.trim(),
                    petAge: petAgeController.text.trim(),
                    breed: breed.value,
                    gender: gender.value, petOwnerId: userModelGlobal.value.userId, petDescription: petDescriptionController.text)
                .toMap());
        await FirebaseCRUDService.instance.updateDocument(collectionReference: FirebaseConstants.userCollection, docId: userModelGlobal.value.userId, data: {
          'totalPets':FieldValue.increment(1)
        });
        print("Pet Added ");
        Utils.hideProgressDialog(context: context);
        CustomSnackBars.instance
            .showCustomSuccessSnackBar(message: "Pet Added Successfully");
      }
    }
  }
}
