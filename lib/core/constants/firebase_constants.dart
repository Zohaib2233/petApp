import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class FirebaseConstants {



  static CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference<Map<String, dynamic>> petsCollectionReference =
  FirebaseFirestore.instance.collection('pets');

  static const String petsCollection = 'pets';
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
}
