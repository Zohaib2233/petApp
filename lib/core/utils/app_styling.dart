import 'package:flutter/material.dart';


import '../constants/app_colors.dart';

class AppStyling {
  textSpanStyle(
      {double fontSize = 9,
      FontWeight fontWeight = FontWeight.w400,
      Color color = kBlackColor1}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
       );
  }

  settingCardDecoration() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
          color: kBlackColor1.withOpacity(0.2),
          blurRadius: 10,
          spreadRadius: 0.5)
    ], color: kWhiteColor, borderRadius: BorderRadius.circular(7.84));
  }

  BoxDecoration adsDecoration() {
    return BoxDecoration(
      color: kWhiteColor,
      borderRadius: BorderRadius.circular(3.81),
    );
  }

  BoxDecoration hospitalCardDecoration() {
    return BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)));
  }

  BoxDecoration onBoardingBkImg(img) {
    return BoxDecoration(
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover));
  }

  TextStyle readmoreStyle(
      {double fontSize = 12,
      FontWeight weight = FontWeight.w500,
      Color color = kSecondaryColor}) {
    return TextStyle(fontSize: fontSize, fontWeight: weight, color: color);
  }
}
