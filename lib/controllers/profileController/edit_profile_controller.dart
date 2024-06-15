import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pet_pal/core/constants/firebase_constants.dart';

import '../../core/global/variables.dart';
import '../../core/services/firebaseServices/firebase_crud.dart';
import '../../core/services/firebaseServices/firebase_storage_service.dart';
import '../../core/utils/snackbar.dart';
import '../../core/utils/utils.dart';
import '../../view/widgets/bottom_sheets/image_picker_bottom_sheet.dart';

class EditProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();

  // TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  RxString combinePhoneNumber = ''.obs;

  RxString profilePath = ''.obs;

  // RxString profileUrl = ''.obs;
  final ImagePicker imagePicker = ImagePicker();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController.text = userModelGlobal.value.name;
    userNameController.text = userModelGlobal.value.username;
    // emailController.text = userModelGlobal.value.email;
    print("Phone Number = ${userModelGlobal.value.phoneNumber}");
    phoneNumberController.text = userModelGlobal.value.phoneNumber.isNotEmpty
        ? userModelGlobal.value.phoneNumber
            .substring(3, userModelGlobal.value.phoneNumber.length)
        : '';

    addressController.text = userModelGlobal.value.address;
    dobController.text = userModelGlobal.value.dob;
  }

  selectDob(BuildContext context) async {
    dobController.text = await Utils.createDatePicker(context);
  }

  void buildOpenImagePickerBottomSheet(
      {required BuildContext context,
      required cameraTap,
      required galleryTap}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (_) {
        return ImagePickerBottomSheet(
            onCameraPick: cameraTap, onGalleryPick: galleryTap);
      },
    );
  }

  pickImageFromCamera() async {
    final XFile? images =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (images!.path.isEmpty) return;
    profilePath.value = images.path;
    update();
  }

  pickImageFromGallery() async {
    final XFile? images =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (images == null) return;
    profilePath.value = images.path;
    update();
  }

  updateProfile({required BuildContext context}) async {
    Utils.showProgressDialog(context: context);
    await FirebaseCRUDService.instance.updateDocument(
      docId: FirebaseConstants.auth.currentUser!.uid,
      collectionReference: FirebaseConstants.userCollection,
      data: {
        'name': nameController.text,
        'address': addressController.text,
        'username': userNameController.text,
        'phoneNumber': combinePhoneNumber.value,
        'dob': dobController.text,
      },
    );

    if (profilePath.isNotEmpty) {
      String profileUrl = await FirebaseStorageService.instance
          .uploadSingleImage(imgFilePath: profilePath.value);
      await FirebaseCRUDService.instance.updateDocument(
          collectionReference: FirebaseConstants.userCollection,
          docId: FirebaseConstants.auth.currentUser!.uid,
          data: {
            'profileUrl': profileUrl,
          });
    }
    Get.back();
    CustomSnackBars.instance.showSuccessSnackbar(
        title: 'Success', message: 'Profile updated successfully');

    Utils.hideProgressDialog(context: context);
  }
}
