
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../my_text_widget.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({
    Key? key,
    required this.onCameraPick,
    required this.onGalleryPick,
  }) : super(key: key);

  final VoidCallback onCameraPick;
  final VoidCallback onGalleryPick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/bottom_sheet_handle.png',
                    height: 5,
                  ),
                ),
                MyText(
                  paddingLeft: 15,
                  paddingTop: 20,
                  paddingBottom: 10,
                  text: 'Upload from',
                  size: 16,
                  color: kSecondaryColor,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: onCameraPick,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/cam.png',
                          height: 25,
                          color: kBlackColor1,
                        ),
                        MyText(
                          paddingTop: 10,
                          text: 'Camera',
                          color: kBlackColor1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: kSecondaryColor,
                    width: 1.0,
                  ),
                  GestureDetector(
                    onTap: onGalleryPick,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/image.png',
                          height: 25,
                          color: kBlackColor1,
                        ),
                        MyText(
                          paddingTop: 10,
                          text: 'Gallery',
                          color: kBlackColor1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}