import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toursy_flutter_revamp/models/loginuser.model.dart';

class LoginService extends ChangeNotifier {

  LoginUserModel? _userModel;

  LoginUserModel? get loggedInUserModel => _userModel;

  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return false;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ) as GoogleAuthCredential;

    // Once signed in, return the UserCredential
    UserCredential userCreds = await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCreds != null) {
      _userModel = LoginUserModel(
        uid: userCreds.user!.uid,
        displayName: userCreds.user!.displayName,
        photoUrl: userCreds.user!.photoURL,
        email: userCreds.user!.email
      );
    }

    notifyListeners();
    
    return true;
  }

  Future<void> signOut(Function callback) async {
    await GoogleSignIn().signOut();
    _userModel = null;
    notifyListeners();

    if (callback != null) {
      callback();
    }
  }

  bool isUserLoggedIn() {
    return _userModel != null;
  }
}