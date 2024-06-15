import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_pal/core/bindings/bindings.dart';
import 'package:pet_pal/core/constants/app_colors.dart';
import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/core/global/variables.dart';
import 'package:pet_pal/models/pets_model.dart';
import 'package:pet_pal/view/screens/details_screen/details_screen.dart';
import 'package:pet_pal/view/screens/homeScreen/pet_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Obx(()=>userModelGlobal.value.userId.isEmpty?const Center(child: CircularProgressIndicator()):StreamBuilder(
          stream: FirebaseConstants.petsCollectionReference.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData) {
              return Text("No Data");
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  PetsModel petsModel =
                  PetsModel.fromSnapshot(snapshot.data!.docs[index]);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: PetCard(
                      onTap: () {
                        Get.to(
                                () =>
                                DetailsScreen(
                                  ownerId: petsModel.petOwnerId,
                                  id: petsModel.petId,
                                  color: Colors.yellow,
                                  petName: petsModel.petName,
                                  breed: petsModel.breed,
                                  age: petsModel.petAge,
                                  gende: petsModel.gender,
                                  imagePath: petsModel.petImage,
                                  petsModel: petsModel,
                                ),
                            binding: DetailScreenBinding(),
                            arguments: petsModel);
                      },
                      imagePath: petsModel.petImage,
                      gender: petsModel.gender,
                      age: petsModel.petAge,
                      breed: petsModel.breed,
                      address: petsModel.petAddress,
                      petName: petsModel.petName,
                      petId: petsModel.petId,
                    ),
                  );
                },
              );
            }
          },
          // child: ListView(
          //   children: [
          //     PetCard(
          //       onTap: () {
          //         Get.to(() => DetailsScreen(
          //             id: '23',
          //             color: Colors.yellow,
          //             petName: 'Bunny',
          //             breed: 'German',
          //             age: '12',
          //             gende: 'male',
          //             imagePath: 'assets/images/dog0.png'));
          //       },
          //       imagePath: 'assets/images/dog0.png',
          //       gender: 'male',
          //       age: '12',
          //       breed: 'German',
          //       distance: '2',
          //       petName: "Bunny",
          //       petId: '23',
          //     ),
          //     PetCard(
          //       imagePath: 'assets/images/dog0.png',
          //       gender: 'male',
          //       age: '12',
          //       breed: 'German',
          //       distance: '2',
          //       petName: "Bunny",
          //       petId: '2323',
          //     ),
          //     PetCard(
          //       imagePath: 'assets/images/dog0.png',
          //       gender: 'male',
          //       age: '12',
          //       breed: 'German',
          //       distance: '2',
          //       petName: "Bunny",
          //       petId: '2324',
          //     ),
          //     PetCard(
          //       imagePath: 'assets/images/dog0.png',
          //       gender: 'male',
          //       age: '12',
          //       breed: 'German',
          //       distance: '2',
          //       petName: "Bunny",
          //       petId: '2325',
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
