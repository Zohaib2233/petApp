
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_pal/core/constants/app_colors.dart';
import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/core/global/functions.dart';
import 'package:pet_pal/view/screens/authScreens/login_screen.dart';
import 'package:pet_pal/view/screens/authScreens/register_screen.dart';
import 'package:pet_pal/view/screens/dashboard/main_screen.dart';

import '../../../core/services/shared_preferences_services.dart';
import '../../../core/utils/shared_pref_keys.dart';
import '../../widgets/common_image_view_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    handleSplash();
    // splashScreenHandler();
  }


  handleSplash() async {
    bool loggedIn = await SharedPreferenceService.instance
          .getSharedPreferenceBool(SharedPrefKeys.isLoggedIn) ??
          false;
    if(loggedIn){
      print("auth.currentUser!.uid ${auth.currentUser!.uid}");
      getUserDataStream(userId: auth.currentUser!.uid);
      Timer(Duration(seconds: 5), () {
        Get.offAll(()=>MainScreen());
      });
    }
    else{
      Timer(Duration(seconds: 5), () {
        Get.offAll(()=>RegisterScreen());
      });
    }

  }

  // void splashScreenHandler() async {
  //   bool onBoardingComplete = await SharedPreferenceService.instance
  //       .getSharedPreferenceBool(SharedPrefKeys.completeOnboarding) ??
  //       false;
  //   bool loggedIn = await SharedPreferenceService.instance
  //       .getSharedPreferenceBool(SharedPrefKeys.loggedIn) ??
  //       false;
  //
  //   print("$onBoardingComplete   $loggedIn");
  //
  //   if (onBoardingComplete && loggedIn) {
  //     Timer(
  //       Duration(seconds: 2),
  //           () => Get.offAll(() => BNavBar(), binding: HomeBindings()),
  //     );
  //     Get.delete<SignupController>();
  //     Get.delete<LoginController>();
  //     print("      getUserDataStream(userId: FirebaseConstants.auth.currentUser!.uid); ${FirebaseConstants.auth.currentUser?.uid}");
  //     getUserDataStream(userId: FirebaseConstants.auth.currentUser!.uid);
  //   } else if (onBoardingComplete) {
  //     Timer(
  //       Duration(seconds: 2),
  //           () => Get.offAll(() => Login()),
  //     );
  //   } else {
  //     Timer(
  //       Duration(seconds: 2),
  //           () => Get.offAll(() => OnBoarding()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Background Art.png')
            )
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CommonImageView(
                //   imagePath: 'assets/images/logo.png',
                //   height: 250,
                //   width: 250,
                //   fit: BoxFit.scaleDown,
                // ),
                ///
                CommonImageView(imagePath: 'assets/images/pet_pal_logo.png',),
                // Text("PET PAL",
                // textAlign: TextAlign.center,
                // style: TextStyle(
                //
                //   fontSize: 28,
                //   fontWeight: FontWeight.w700,
                //   color: kSecondaryColor
                // ),)
              ],
            ),
          ),
        ));
  }
}