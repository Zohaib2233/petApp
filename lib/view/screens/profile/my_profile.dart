import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_pal/core/services/firebaseServices/firebase_crud.dart';
import 'package:pet_pal/core/utils/app_strings.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/global/variables.dart';
import '../../../models/user_model.dart';
import '../../widgets/my_text_widget.dart';

// ignore: must_be_immutable
class MyProfile extends StatefulWidget {
  // bool isListingDetailProfile;
  // final int? noOfExp;
  final UserModel userModel;

  MyProfile({Key? key, required this.userModel}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.userModel.userId == userModelGlobal.value.userId) {
      userModel = userModelGlobal.value;
    } else {
     userModel=widget.userModel;
    }
  }

  // getUserDetails() async {
  //   userModel = await FirebaseCRUDService.instance
  //           .getUserDetail(docId: widget.userId) ??
  //       UserModel(
  //           userId: '',
  //           name: '',
  //           username: '',
  //           email: '',
  //           phoneNumber: '',
  //           profileUrl: dummyProfile,
  //           dob: '');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ),
        children: [
          Container(
            height: 260,
            padding: const EdgeInsets.only(top: 30),
            width: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/bk_decoration_png_img.png'),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: Get.width * 0.05),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_ios))
                  ],
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(userModel.profileUrl),
                          fit: BoxFit.contain)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              children: [
                DetailTile(
                  title: 'Name',
                  subTitle: userModel.name,
                ),
                DetailTile(
                  title: 'Username',
                  subTitle: userModel.username,
                ),
                DetailTile(
                  title: 'Address',
                  subTitle: userModel.address,
                ),
                DetailTile(
                  title: 'Date of Birth',
                  subTitle: userModel.dob,
                ),
                DetailTile(
                  title: 'Email',
                  subTitle: userModel.email,
                ),
                DetailTile(
                  title: 'Phone No',
                  subTitle: userModel.phoneNumber,
                ),
                DetailTile(
                  title: 'Total Pets',
                  subTitle: '${userModel.totalPets}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailTile extends StatelessWidget {
  final String title, subTitle;

  const DetailTile({
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MyText(
            text: title,
            size: 16,
            color: kTextColor2,
            weight: FontWeight.w600,
            paddingLeft: 8,
            paddingBottom: 8,
          ),
          MyText(
            text: subTitle,
            size: 14,
            color: kTextColor3,
            paddingLeft: 8,
            paddingBottom: 18,
          ),
          const CustomDivider(),
        ],
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.53,
      color: kBorderColor2,
    );
  }
}
