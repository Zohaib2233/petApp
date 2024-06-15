import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/models/pets_model.dart';

import '../../../../../core/bindings/bindings.dart';
import '../../../../../core/utils/lists.dart';
import '../../../details_screen/details_screen.dart';
import '../../../homeScreen/pet_card.dart';

class MatchMakingScreen extends StatelessWidget {
  final PetsModel petsModel;

  const MatchMakingScreen({super.key, required this.petsModel});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseConstants.petsCollectionReference.where(
            Filter.and(Filter('breed', isEqualTo: petsModel.breed),
                Filter('gender', isEqualTo: dogsGender[petsModel.gender])))
            .snapshots(),
        builder:(BuildContext context,
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
                              () => DetailsScreen(
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
        },);
  }
}
