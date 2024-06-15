import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_pal/core/global/functions.dart';
import 'package:pet_pal/core/utils/utils.dart';
import 'package:pet_pal/view/screens/dashboard/main_screen.dart';
import 'package:pet_pal/view/screens/homeScreen/home_Screen.dart';

import '../../core/constants/firebase_constants.dart';
import '../../core/services/shared_preferences_services.dart';
import '../../core/utils/shared_pref_keys.dart';
import '../../core/utils/snackbar.dart';


class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  RxBool isLoading = false.obs;
  RxBool isChecked = false.obs;


  changeCheckValue(bool value){
    isChecked.value = value;
  }

  Future loginWithEmailPassword(BuildContext context) async {

      try {
        isLoading(true);

        await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        if (FirebaseAuth.instance.currentUser != null) {
          if (isChecked.isTrue) {
            SharedPreferenceService.instance.saveSharedPreferenceBool(
                key: SharedPrefKeys.isLoggedIn, value: true);
          }
          isLoading(false);
          CustomSnackBars.instance
              .showCustomSuccessSnackBar(message: "Successfully Login");
          getUserDataStream(userId: FirebaseAuth.instance.currentUser!.uid);
          Get.offAll(() => const MainScreen());
        }
        // Utils.hideProgressDialog(context: context);
      } on FirebaseAuthException catch (e) {
        //popping progress indicator

        // Utils.hideProgressDialog(context: context);
        // Get.back();
        isLoading(false);

        if (e.code == "invalid-credential" ||
            e.code == "INVALID_LOGIN_CREDENTIALS") {
          //showing failure snackbar
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Authentication Error',
              message:
                  "You have entered incorrect credentials, please try again!");
        } else {

          //showing failure snackbar
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Authentication Error', message: "${e.message}");
        }
      } on FirebaseException catch (e) {
        //popping progress indicator
        // Get.back();
        // Navigator.pop(context);
        isLoading(false);

        //showing failure snackbar
        CustomSnackBars.instance.showFailureSnackbar(
            title: 'Authentication Error', message: "${e.message}");
      } catch (e) {
        isLoading(false);
        log("This was the exception while logging in user: $e");
      }



  }
}
