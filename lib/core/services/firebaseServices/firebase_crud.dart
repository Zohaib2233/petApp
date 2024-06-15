import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/models/user_model.dart';

import '../../utils/snackbar.dart';




class FirebaseCRUDService {
  // ---------------- Create Singleton -------------------------
  //private constructor
  FirebaseCRUDService._privateConstructor();

  //singleton instance variable
  static FirebaseCRUDService? _instance;

  //This code ensures that the singleton instance is created only when it's accessed for the first time.
  //Subsequent calls to FirebaseCRUDService.instance will return the same instance that was created before.

  //getter to access the singleton instance
  static FirebaseCRUDService get instance {
    _instance ??= FirebaseCRUDService._privateConstructor();
    return _instance!;
  }



  String getCollectionId({required CollectionReference collectionReference}){
    DocumentReference reference = collectionReference.doc();
    return reference.id;

  }

  /// Create Document
  Future<bool> createDocument(
      {required CollectionReference collectionReference,
        required String docId,
        required Map<String, dynamic> data}) async {
    try {
      await collectionReference.doc(docId).set(data);

      //returning true to indicate that the document is created
      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      log("This was the exception while creating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }


  /// update Document
  Future<bool> updateDocument(
      {required CollectionReference collectionReference,
        required String docId,
        required Map<String, dynamic> data}) async {
    try {
      await collectionReference.doc(docId).update(data);

      //returning true to indicate that the document is created
      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      log("This was the exception while creating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  Future<UserModel?> getUserDetail(
      {
        required String docId,
        }) async {
    try {
      DocumentSnapshot<Map<String,dynamic>> documentSnapshot = await FirebaseConstants.userCollection.doc(docId).get();
        // .doc(docId).update(data);

      //returning true to indicate that the document is created
      return UserModel.fromJson(documentSnapshot.data() as Map<String,dynamic>);
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return null;
    } catch (e) {
      log("This was the exception while creating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return null;
    }
  }


  /// check if the document exists in Firestore
  Future<bool> isDocExist(
      {required CollectionReference collectionReference,
        required String docId}) async {
    try {
      DocumentSnapshot documentSnapshot =
      await collectionReference.doc(docId).get();

      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      log("This was the exception while reading document from Firestore: $e");

      return false;
    } catch (e) {
      log("This was the exception while reading document from Firestore: $e");

      return false;
    }
  }
  
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchPetsByOwnerId({required String ownerId}){
    
    return FirebaseConstants.petsCollectionReference.where('petOwnerId',isEqualTo: ownerId).snapshots();
    
  }


  /// Method to get a user-friendly message from FirebaseException
  String getFirestoreErrorMessage(FirebaseException e) {
    switch (e.code) {
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'unknown':
        return 'An unknown error occurred.';
      case 'invalid-argument':
        return 'Invalid argument provided.';
      case 'deadline-exceeded':
        return 'The deadline was exceeded, please try again.';
      case 'not-found':
        return 'Requested document was not found.';
      case 'already-exists':
        return 'The document already exists.';
      case 'permission-denied':
        return 'You do not have permission to execute this operation.';
      case 'resource-exhausted':
        return 'Resource limit has been exceeded.';
      case 'failed-precondition':
        return 'The operation failed due to a precondition.';
      case 'aborted':
        return 'The operation was aborted, please try again.';
      case 'out-of-range':
        return 'The operation was out of range.';
      case 'unimplemented':
        return 'This operation is not implemented or supported yet.';
      case 'internal':
        return 'Internal error occurred.';
      case 'unavailable':
        return 'The service is currently unavailable, please try again later.';
      case 'data-loss':
        return 'Data loss occurred, please try again.';
      case 'unauthenticated':
        return 'You are not authenticated, please login and try again.';
      default:
        return 'An unexpected error occurred, please try again.';
    }
  }
}
