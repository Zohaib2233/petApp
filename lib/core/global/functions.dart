


import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/core/global/variables.dart';
import 'package:pet_pal/models/user_model.dart';

getUserDataStream({required String userId}){
  FirebaseConstants.userCollection.doc(userId).snapshots().listen((event) {
    userModelGlobal.value = UserModel.fromJson(event.data()!);
  });
}