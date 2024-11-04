import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pmproject/core/services/log_service.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static bool isLoggedIn() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser != null;
  }

  static User currentUser() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser!;
  }

  static Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(credential);
      }
    } on Exception catch (e) {
      LogService.e("$e");
      // print('exception->$e');
    }
  }

  // static Future<void> signInWithGoogle(
  //     void Function(String errorMessage) errorCallback,
  //     ) async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth!.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //   }
  //   on PlatformException catch (e) {
  //     if (e.code == GoogleSignIn.kNetworkError) {
  //       String errorMessage = "A network error (such as timeout, interrupted connection or unreachable host) has occurred.";
  //       errorCallback(errorMessage);
  //     } else {
  //       String errorMessage = "Something went wrong.";
  //       errorCallback(errorMessage);
  //     }
  //   }
  // }

  static Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}