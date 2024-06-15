import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/core/services/firebaseServices/firebase_crud.dart';
import 'package:pet_pal/models/pets_model.dart';

import '../core/services/image_picker_service.dart';

class EditPetController extends GetxController {



  RxString imagePath = ''.obs;


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




}