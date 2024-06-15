import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_pal/core/constants/app_colors.dart';
import 'package:pet_pal/core/global/variables.dart';
import 'package:pet_pal/core/services/firebaseServices/firebase_crud.dart';


import '../../../models/pets_model.dart';
import '../homeScreen/pet_card.dart';

import 'myPetDetail/my_pet_detail_screen.dart';

class MyPetsScreen extends StatefulWidget {
  const MyPetsScreen({super.key});

  @override
  State<MyPetsScreen> createState() => _MyPetsScreenState();
}

class _MyPetsScreenState extends State<MyPetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: StreamBuilder(
          stream: FirebaseCRUDService.instance.fetchPetsByOwnerId(ownerId: userModelGlobal.value.userId),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if(!snapshot.hasData){
              return const Center(child: Text("Not Pets"),);
            }
            else{
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                PetsModel petsModel = PetsModel.fromSnapshot(snapshot.data!.docs[index]);
                return   Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: PetCard(
                    onTap: () {
                      Get.to(()=> MyPetDetailScreen(
                        petsModel: petsModel,
                      ));
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
              },);
            }
          },
          // child: ListView(
          //   children: [
          //     Text("My Pets",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //       fontSize: 22,
          //       fontWeight: FontWeight.w600
          //     ),),
          //     SizedBox(height: 20,),
          //     PetCard(
          //       onTap: (){
          //         Get.to(()=>MyPetDetailScreen());
          //       },
          //       imagePath: 'assets/images/dog0.png',
          //       gender: 'male',
          //       age: '12',
          //       breed: 'German',
          //       distance: '2',
          //       petName: "Bunny",
          //       petId: '232',
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
          //   ],
          // ),
        ),
      ),
    );
  }
}
