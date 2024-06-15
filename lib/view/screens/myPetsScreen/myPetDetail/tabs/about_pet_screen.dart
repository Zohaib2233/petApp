import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pet_pal/core/constants/app_colors.dart';
import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/core/services/firebaseServices/firebase_crud.dart';
import 'package:pet_pal/core/utils/dialogs.dart';
import 'package:pet_pal/core/utils/lists.dart';
import 'package:pet_pal/core/utils/snackbar.dart';
import 'package:pet_pal/models/pets_model.dart';
import 'package:pet_pal/view/screens/myPetsScreen/myPetDetail/edit_pet_detail.dart';
import 'package:pet_pal/view/widgets/common_image_view_widget.dart';
import 'package:pet_pal/view/widgets/my_button.dart';
import 'package:pet_pal/view/widgets/my_text_widget.dart';

import '../../../../../core/utils/utils.dart';

class PetAboutScreen extends StatelessWidget {
  final PetsModel petsModel;

  const PetAboutScreen({super.key, required this.petsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: Get.height * 0.28,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CommonImageView(
                    fit: BoxFit.fill,
                    url: petsModel.petImage,
                  ),
                ),
              ),
              SizedBox(height: 20),
              MyText(text: "${petsModel.petName}",
                size: 28,
                weight: FontWeight.bold,),
              MyText(text: petsModel.breed),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedContainer(
                    label: 'Gender',
                    value: petsModel.gender,
                  ),
                  RoundedContainer(
                    label: 'Age',
                    value: '${petsModel.petAge} years',
                  ),
                ],
              ),
              SizedBox(height: 10),

              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  leading: CommonImageView(
                    imagePath: 'assets/images/vaccine.png',
                    height: 100,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        petsModel.vaccinations.isEmpty
                            ? "Not Vaccinated Yet"
                            : "Vaccinated",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Next vaccination: -${petsModel.vaccinations.isEmpty
                            ? ''
                            : 'After ${vaccinesForDogsMap[petsModel.vaccinations.last]} for ${petsModel.vaccinations
                            .last}'}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 40,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        petsModel.petAddress,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: MyButton(onTap: () {
                      Get.to(() => EditPetDetailScreen(petsModel: petsModel));
                    }, buttonText: 'Edit'),
                  ),
                  SizedBox(width: 30,),
                  Expanded(
                    child: MyButton(
                        backgroundColor: Colors.red,
                        onTap: () {
                          showDialog(context: context, builder: (context) {
                            return MyAlertDialog(
                              onDeletePressed: () async {
                                Utils.showProgressDialog(context: context);
                                await FirebaseConstants.petsCollectionReference
                                    .doc(petsModel.petId).delete();
                                CustomSnackBars.instance
                                    .showCustomSuccessSnackBar(
                                    message: "Pet Deleted Successfully");
                                Get.close(2);
                              },
                            );
                          },);
                        }, buttonText: "Delete"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class RoundedContainer extends StatelessWidget {
  final String label;
  final String value;

  const RoundedContainer({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Get.width * 0.3,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

