import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_pal/core/utils/shared_pref_keys.dart';
import 'package:pet_pal/view/screens/authScreens/login_screen.dart';

import '../constants/firebase_constants.dart';
import '../services/shared_preferences_services.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              color: Colors.white,

              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height*0.02),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: width*0.25,
                      child: Center(
                        child: Text("Log out of your account?",
                          style: TextStyle(fontSize: 18),),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    TextButton(onPressed: () async {
                      ///
                      await auth.signOut();
                      SharedPreferenceService.instance.removeSharedPreferenceBool(SharedPrefKeys.isLoggedIn);
                      Get.offAll(()=>LoginScreen());

                    }, child: Text("Log Out",
                        style: TextStyle(fontSize: 16))),
                    Divider(thickness: 2,),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel",
                        style: TextStyle(fontSize: 16)))


                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}



class MyAlertDialog extends StatelessWidget {
  final Function() onDeletePressed;
  const MyAlertDialog({super.key, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,

      title: Text("Confirmation"),
      content: Text("Do you want to delete it?"),
      actions: [
        TextButton(
          onPressed: () {
            // Handle cancel action
            Navigator.of(context).pop(false); // Close the dialog and return false
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            // Handle delete action
            Navigator.of(context).pop(true); // Close the dialog and return true
            onDeletePressed();
          },
          child: Text("Delete",style: TextStyle(color: Colors.red),),
        ),
      ],
    );
  }
}