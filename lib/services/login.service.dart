import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/models/loginuser.model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

      var photoUrl = '';
      var displayName = '';
      var email = '';

      if (userCreds.user!.email! != null) {
        email = userCreds.user!.email!;
      }

      if (userCreds.user!.displayName != null) {
       displayName = userCreds.user!.displayName!; 
      }
      else {
        // pull it from the provider data
        if (userCreds.user!.providerData != null && 
          userCreds.user!.providerData.isNotEmpty) {
            displayName = userCreds.user!.providerData[0].displayName!;
          
        }
      }

      if (userCreds.user!.photoURL != null) {
        photoUrl = userCreds.user!.photoURL!;
      }
      else {
        // pull it from the provider data
        if (userCreds.user!.providerData != null && 
          userCreds.user!.providerData.isNotEmpty) {
            photoUrl = userCreds.user!.providerData[0].photoURL!;
        }
      }

      _userModel = LoginUserModel(
        uid: userCreds.user!.uid,
        displayName: displayName,
        photoUrl: photoUrl,
        email: email
      );
    }

    notifyListeners();
    
    return true;
  }

  Future<bool> signInWithApple() async {
    
    final rawNonce = generateNonce();
    final nonce = Utils.sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    UserCredential userCreds = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    if (userCreds != null) {

      var photoUrl = '';
      var displayName = '';
      var email = '';

      if (userCreds.user!.email! != null) {
        email = userCreds.user!.email!;
      }

      if (userCreds.user!.displayName != null) {
       displayName = userCreds.user!.displayName!; 
      }
      else {
        // pull it from the provider data
        if (userCreds.user!.providerData != null && 
          userCreds.user!.providerData.isNotEmpty) {
            displayName = userCreds.user!.providerData[0].displayName!;
        }
      }

      if (userCreds.user!.photoURL != null) {
        photoUrl = userCreds.user!.photoURL!;
      }
      else {
        // pull it from the provider data
        if (userCreds.user!.providerData != null && 
          userCreds.user!.providerData.isNotEmpty) {
            photoUrl = userCreds.user!.providerData[0].photoURL!;
        }
      }

      _userModel = LoginUserModel(
        uid: userCreds.user!.uid,
        displayName: displayName,
        photoUrl: photoUrl,
        email: email
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