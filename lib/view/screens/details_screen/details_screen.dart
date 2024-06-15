import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:pet_pal/controllers/detail_screen_controller.dart';
import 'package:pet_pal/core/constants/app_colors.dart';
import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/core/services/firebaseServices/firebase_crud.dart';
import 'package:pet_pal/core/utils/app_strings.dart';
import 'package:pet_pal/view/screens/profile/my_profile.dart';
import 'package:pet_pal/view/widgets/common_image_view_widget.dart';
import 'package:pet_pal/view/widgets/my_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/pets_model.dart';
import '../../../models/user_model.dart';

class DetailsScreen extends StatefulWidget {
  final String id;
  final Color color;
  final String petName;
  final String breed;
  final String age;
  final String gende;
  final String imagePath;
  final String ownerId;
  final PetsModel petsModel;

  DetailsScreen(
      {required this.id,
      required this.color,
      required this.petName,
      required this.breed,
      required this.age,
      required this.gende,
      required this.imagePath,
      required this.ownerId, required this.petsModel});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var controller = Get.find<DetailScreenController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getPetOwnerDetail(ownerId: widget.ownerId);

  }
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.symmetric(
                    //     vertical: 60, horizontal: 30),
                    color: widget.color,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Hero(
                            tag: widget.id,
                            child: CommonImageView(
                              fit: BoxFit.cover,
                              url: widget.imagePath,
                              width: size.width,
                              height: size.height,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(()=>MyProfile(userModel: controller.petOwnerModel.value));
                          },
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 10),

                            margin: const EdgeInsets.symmetric(
                                horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset:
                                      const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(()=>CommonImageView(
                                      height: 40,
                                      width: 40,
                                      radius: 30,
                                      url: controller.petOwnerModel.value.profileUrl,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(
                                        () => Text(
                                          controller.petOwnerModel.value.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const Text(
                                        'Owner',
                                        style: TextStyle(
                                          color: kBlackColor1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  const Text(
                                    'Feb 16, 2024',
                                    style: TextStyle(
                                      color: kBlackColor1,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            widget.petsModel.petDescription,
                            style: TextStyle(
                              color: kBlackColor1,
                              height: 1.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(
          //       vertical: 42,
          //       horizontal: 20,
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         IconButton(
          //           icon: const Icon(CupertinoIcons.chevron_left,color: Colors.white,),
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           },
          //         ),
          //
          //       ],
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 135,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300] as Color,
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.petName,
                        style: const TextStyle(
                          color: kBlackColor1,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        widget.gende == 'Female'
                            ? FontAwesomeIcons.venus
                            : FontAwesomeIcons.mars,
                        size: 22,
                        color: Colors.black54,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.breed,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.age + ' years',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 5,),
                Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 18,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          widget.petsModel.petAddress,
                          style: const TextStyle(
                            fontSize: 14,
                            color: kBlackColor1,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(()=>Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: IconButton(
                        onPressed: () {
                          controller.savedPet();
                          print("Pressed");
                        },
                        icon: controller.isSaved.isFalse? Icon(Icons.favorite_border):Icon(Icons.favorite),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: MyButton(
                        onTap: () {
                          print("Contact ${controller.petOwnerModel.value.phoneNumber.trim().substring(1,controller.petOwnerModel.value.phoneNumber.length)}");
                          if(controller.petOwnerModel.value.phoneNumber!='') {
                            _launchInBrowserView(Uri.parse('https://wa.me/${controller.petOwnerModel.value.phoneNumber.substring(1)}?text=I\'m%20interested%20in%20your%20pet'));
                          }
                        },
                        buttonText: 'Contact',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchInBrowserView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }
}
