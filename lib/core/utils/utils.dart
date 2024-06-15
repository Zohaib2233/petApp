import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_pal/core/constants/app_colors.dart';

import '../../view/widgets/bottom_sheets/image_picker_bottom_sheet.dart';

class Utils {
  static createDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(

        context: context,
        initialDate: DateTime.now(),
        //get today's date
        firstDate: DateTime(1940),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      // print(pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000

      String formattedDate = DateFormat('dd/MM/yyyy').format(
          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
      // print(
      //     formattedDate); //formatted date output using intl package =>  2022-07-04
      //You can format date as per your need
      // return formattedDate;
      return formattedDate;
    } else {
      Get.back();
      print("Date is not selected");
    }
  }


  static void showProgressDialog({required BuildContext context}) {
    //showing progress indicator
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Center(child: CircularProgressIndicator())));
  }

  static hideProgressDialog({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showImagePickerBottomSheet(
      {required BuildContext context,
        required VoidCallback onCameraPick,
        required VoidCallback onGalleryPick}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (_) {
        return ImagePickerBottomSheet(
          onCameraPick: onCameraPick,
          onGalleryPick: onGalleryPick,
        );
      },
    );
  }
}
