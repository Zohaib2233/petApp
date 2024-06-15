import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/core/global/variables.dart';
import 'package:pet_pal/models/pets_model.dart';

import '../core/services/firebaseServices/firebase_crud.dart';
import '../core/utils/app_strings.dart';
import '../models/user_model.dart';

class DetailScreenController extends GetxController{
  
  late PetsModel petsModel;

  Rx<UserModel> petOwnerModel = UserModel(
      userId: '',
      name: '',
      email: '',
      phoneNumber: '',
      profileUrl: dummyProfile,
      dob: '', username: '')
      .obs;

  RxBool isSaved = false.obs;

  DetailScreenController(petsModel);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("Get.arguments = ${Get.arguments}");

    petsModel = Get.arguments;
    isSaved.value = userModelGlobal.value.savedPets.contains(petsModel.petId);


  }

  getPetOwnerDetail({required String ownerId}) async {
    petOwnerModel.value = await FirebaseCRUDService.instance.getUserDetail(docId: ownerId)??petOwnerModel.value;
  }


  savedPet() async {
    if(isSaved.isFalse){
      isSaved.value = true;
      await FirebaseCRUDService.instance.updateDocument(collectionReference: FirebaseConstants.userCollection, docId: userModelGlobal.value.userId, data: {
        'savedPets':FieldValue.arrayUnion([petsModel.petId])
      });


    }
    else{
      isSaved.value = false;
      await FirebaseCRUDService.instance.updateDocument(collectionReference: FirebaseConstants.userCollection, docId: userModelGlobal.value.userId, data: {
        'savedPets':FieldValue.arrayRemove([petsModel.petId])
      });
    }
  }


}