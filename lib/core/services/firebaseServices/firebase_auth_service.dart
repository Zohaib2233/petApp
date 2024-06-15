import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/snackbar.dart';

class FirebaseAuthService {
  FirebaseAuthService._privateConstructor();

  static FirebaseAuthService? _instance;

  static FirebaseAuthService get instance {

    _instance??=FirebaseAuthService._privateConstructor();
    return _instance!;
  }

  Future<User?> signUpUsingEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential? userCredential =  await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser != null) {
        User user = FirebaseAuth.instance.currentUser!;

        return user;
      }
      if (FirebaseAuth.instance.currentUser == null) {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

      return null;
    } on FirebaseException catch (e) {
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

      return null;
    } catch (e) {
      log("This was the exception while signing up: $e");

      return null;
    }

    return null;
  }
  //
  // Future<UserCredential> signInWithFacebook() async {
  //   try {
  //     final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //     if (loginResult.status == LoginStatus.success) {
  //       final AccessToken accessToken = loginResult.accessToken!;
  //       final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
  //       return await FirebaseAuth.instance.signInWithCredential(credential);
  //     } else {
  //       throw FirebaseAuthException(
  //         code: 'Facebook Login Failed',
  //         message: 'The Facebook login was not successful.',
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     // Handle Firebase authentication exceptions
  //     print('Firebase Auth Exception: ${e.message}');
  //     throw e; // rethrow the exception
  //   } catch (e) {
  //     // Handle other exceptions
  //     print('Other Exception: $e');
  //     throw e; // rethrow the exception
  //   }
  // }
  //
  //
  // Future<(User?, GoogleSignInAccount?, bool)> authWithGoogle() async {
  //   try {
  //     final GoogleSignIn _googleSignIn = GoogleSignIn();
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //     await googleUser!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     // TODO: Use the `credential` to sign in with Firebase.
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     if (FirebaseAuth.instance.currentUser == null) {
  //       return (null, null, false);
  //     }
  //
  //     if (FirebaseAuth.instance.currentUser != null) {
  //       User user = FirebaseAuth.instance.currentUser!;
  //
  //       //checking if the user's account already exists on firebase
  //       bool isExist = await FirebaseCRUDService.instance.isDocExist(collectionReference: FirebaseConsts.userCollectionRef, docId: user.uid);
  //
  //       return (user, googleUser, isExist);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     //showing failure snackbar
  //     CustomSnackBars.instance.showFailureSnackbar(
  //         title: 'Authentication Error', message: '${e.message}');
  //
  //     return (null, null, false);
  //   } on FirebaseException catch (e) {
  //     //showing failure snackbar
  //     CustomSnackBars.instance.showFailureSnackbar(
  //         title: 'Authentication Error', message: '${e.message}');
  //
  //     return (null, null, false);
  //   } catch (e) {
  //     log("This was the exception while signing up: $e");
  //
  //     return (null, null, false);
  //   }
  //
  //   return (null, null, false);
  // }

  //reAuthenticating user to confirm if the same user is requesting
  Future<void> changeFirebaseEmail(
      {required String email,
        required String password,
        required String newEmail}) async {
    try {
      final User user = await FirebaseAuth.instance.currentUser!;

      final cred =
      EmailAuthProvider.credential(email: email, password: password);

      await user.reauthenticateWithCredential(cred).then((value) async {
        await user.verifyBeforeUpdateEmail(newEmail);

        CustomSnackBars.instance.showSuccessSnackbar(
          title: "Verification Link Sent",
          message:
          "Please update your email by verifying it through the link provided in the verification email we have sent to you.",
          duration: 6,
        );

        //logging out user (so that we can update his email on the Firebase when he logs in again)
        await FirebaseAuth.instance.signOut();

        //deleting isRemember me key from local storage
        // await LocalStorageService.instance.deleteKey(key: "isRememberMe");
        //
        // //putting the controllers again
        // Get.put<SignUpController>(SignUpController());
        // Get.put<LoginController>(LoginController());
        // Get.put<FirebaseAuthService>(FirebaseAuthService());
        //
        // //navigating back to Login Screen
        // Get.offAll(() => Login());
      }).onError((error, stackTrace) {
        CustomSnackBars.instance
            .showFailureSnackbar(title: 'Error', message: '$error');
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'User not found');
          break;
        case 'wrong-password':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'Wrong password');
          break;
        case 'invalid-email':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'Invalid email');
          break;
        case 'email-already-in-use':
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Error', message: 'Email already in use');
          break;
        default:
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Retry', message: 'Something went wrong');
          break;
      }
    }
  }

  //method to change Firebase password
  Future<void> changeFirebasePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred =
    EmailAuthProvider.credential(email: email, password: oldPassword);

    try {
      user!.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) {
          CustomSnackBars.instance.showSuccessSnackbar(
              title: "Success", message: "Password updated successfully");
        }).onError((error, stackTrace) {
          CustomSnackBars.instance
              .showFailureSnackbar(title: "Failure", message: "$error");
        });
      }).onError((error, stackTrace) {
        CustomSnackBars.instance
            .showFailureSnackbar(title: "Failure", message: "$error");
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'User not found');
          break;
        case 'wrong-password':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'Wrong password');
          break;
        case 'invalid-email':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'Invalid email');
          break;
        case 'email-already-in-use':
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Error', message: 'Email already in use');
          break;
        default:
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Retry', message: 'Something went wrong');
          break;
      }
    }
  }

}