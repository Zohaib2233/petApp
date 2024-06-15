import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/core/utils/utils.dart';
import 'package:pet_pal/view/screens/dashboard/main_screen.dart';


import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/global/variables.dart';
import '../../../core/services/firebaseServices/firebase_crud.dart';
import '../../../core/services/shared_preferences_services.dart';
import '../../../core/utils/app_styling.dart';
import '../../../core/utils/shared_pref_keys.dart';
import '../../../core/utils/snackbar.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  String inputOtp ='';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding: AppSizes.DEFAULT,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BackBtn(),
                    MyText(
                      paddingTop: 32,
                      paddingBottom: 19,
                      text: "Almost there ",
                      size: 24,
                      weight: FontWeight.w600,
                    ),
                    RichText(
                          text: TextSpan(
                              text:
                                  "Please enter the 4-digit code sent to your email ",
                              style: AppStyling().textSpanStyle(
                                  fontWeight: FontWeight.w300, fontSize: 14),
                              children: [
                            //-----------------------
                            /// Insert User Email Here
                            //-----------------------
                            TextSpan(
                              text: "${FirebaseAuth.instance.currentUser!.email}",
                              style: AppStyling().textSpanStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kSecondaryColor,
                                  fontSize: 14),
                            ),

                            TextSpan(text: " for verification."),
                          ]),
                    ),

                    SizedBox(height: 31),

                    _OtpFields(onCodeChanged: (code) {
                      if(code == ''){
                        inputOtp='';
                      }
                      inputOtp+=code;

                      print(code);
                    }),

                    SizedBox(height: 51),

                    // veerify Button

                    MyButton(
                        buttonText: "Verify",
                        onTap: () async{
                          if(inputOtp.isNotEmpty){
                            Utils.showProgressDialog(context: context);
                            print("88888888888888888888888888888888");
                            print(await myAuth.verifyOTP(otp: inputOtp));
                            if( await myAuth.verifyOTP(otp: inputOtp)==true){
                              CustomSnackBars.instance.showCustomSuccessSnackBar(message: "OTP Verfied");
                              await FirebaseCRUDService.instance.updateDocument(collectionReference: FirebaseConstants.userCollection, docId: userModelGlobal.value.userId, data: {
                                'emailVerified':true
                              });
                              SharedPreferenceService.instance.saveSharedPreferenceBool(
                                  key: SharedPrefKeys.isLoggedIn, value: true);
                              Utils.hideProgressDialog(context: context);
                              Get.offAll(()=>MainScreen());
                            }
                            else{
                              Utils.hideProgressDialog(context: context);
                              CustomSnackBars.instance.showFailureSnackbar(title: 'Wrong Otp', message: "Please Enter Correct OTP");
                            }
                          }
                          ///Todo:
                          // Get.to(()=>MainScreen());
                          print("-------------------------- $inputOtp -----------");
                          // Get.to(() => BottomNavBar());
                        }),

                    SizedBox(height: 26),

                    // Resend Button

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          paddingRight: 2,
                          text: 'Didn’t receive any code?',
                          size: 13,
                          weight: FontWeight.w400,
                        ),
                        MyText(
                          onTap: () {},
                          text: 'Resend Again',
                          size: 13,
                          weight: FontWeight.w500,
                          color: kSecondaryColor,
                        ),
                      ],
                    ),
                    // Count Time
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: MyText(
                    //     text: 'Request new code in 00:30s',
                    //     size: 13,
                    //     weight: FontWeight.w300,
                    //     color: kBlackColor50Percent,
                    //   ),
                    // ),
                  ],
                )),
          )),
    );
  }
}

class _OtpFields extends StatelessWidget {
  final Function(dynamic)? onCodeChanged;
  const _OtpFields({super.key, required this.onCodeChanged});

  @override
  Widget build(BuildContext context) {
    return OtpTextField(

      numberOfFields: 4,
      filled: false,
      fillColor: kTertiaryColor,
      borderColor: kTertiaryColor,
      focusedBorderColor: kBlackColor1,
      borderWidth: 1,
      borderRadius: BorderRadius.circular(50),
      showFieldAsBox: true,
      fieldWidth: 60,
      textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: kBlackColor1,
          ),
      onCodeChanged: onCodeChanged,

    );
  }
}
