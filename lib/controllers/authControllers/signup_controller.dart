import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/core/global/functions.dart';
import 'package:pet_pal/core/services/firebaseServices/firebase_auth_service.dart';
import 'package:pet_pal/core/services/firebaseServices/firebase_crud.dart';
import 'package:pet_pal/core/utils/app_strings.dart';
import 'package:pet_pal/core/utils/snackbar.dart';
import 'package:pet_pal/models/user_model.dart';
import 'package:pet_pal/view/screens/authScreens/otp.dart';

import '../../core/global/variables.dart';
import '../../core/utils/utils.dart';

class SignupController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController againPasswordController = TextEditingController();
  Rx<TextEditingController> dobController = TextEditingController().obs;

  RxString combineNumber = ''.obs;

  selectDob(BuildContext context) async {
    String? date = await Utils.createDatePicker(context);
    if (date != null) {
      dobController.value.text = date;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    againPasswordController.dispose();
    dobController.value.dispose();
    addressController.dispose();
  }

  combinePhoneNumber(PhoneNumber number) {
    phoneController.text = number.number ?? '';
    combineNumber.value = '${number.countryCode}${number.number}';
    print(combineNumber.value);
  }


  registerUser(BuildContext context) async {
    if (combineNumber.isEmpty) {
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Phone Number Required", message: "Please Enter Phone Number");
    }
    else{
      Utils.showProgressDialog(context: context);
      User? user = await FirebaseAuthService.instance.signUpUsingEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (user != null) {
        await FirebaseCRUDService.instance.createDocument(
            collectionReference: FirebaseConstants.userCollection,
            docId: user.uid,
            data: UserModel(
              address: addressController.text,
              username: usernameController.text,
                userId: user.uid,
                name: nameController.text.trim(),
                email: emailController.text.trim(),
                phoneNumber: combineNumber.value,
                profileUrl: dummyProfile,
                dob: dobController.value.text).toJson());
        Utils.hideProgressDialog(context: context);
        getUserDataStream(userId: user.uid);
        CustomSnackBars.instance.showSuccessSnackbar(title: "Success", message: "Otp has been send to your email");
        myAuth.setConfig(
            appEmail: "syedzebi.hassan@gmail.com",
            appName: "Email OTP",
            userEmail: emailController.text.trim(),
            otpLength: 4,
            otpType: OTPType.digitsOnly
        );
        if(myAuth.sendOTP()==true){
          CustomSnackBars.instance.showCustomSuccessSnackBar(message: "OTP Send");
        }

        Get.offAll(()=>OtpScreen());
      }

    }
    }

}
