// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBla8yhZmc2m3zIdkuPhbE4aaj0tB7tYng',
    appId: '1:369199371889:web:9b6967946e49153b112dd0',
    messagingSenderId: '369199371889',
    projectId: 'toursy-app',
    authDomain: 'toursy-app.firebaseapp.com',
    storageBucket: 'toursy-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwryd39GV9Fkqq8_pITqLOcllIqV89GX8',
    appId: '1:369199371889:android:7b74bfd89137e95d112dd0',
    messagingSenderId: '369199371889',
    projectId: 'toursy-app',
    storageBucket: 'toursy-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChoLTQAuXl86r4vIQtGJKgux--vsz7UqE',
    appId: '1:369199371889:ios:72d3c900ac784c02112dd0',
    messagingSenderId: '369199371889',
    projectId: 'toursy-app',
    storageBucket: 'toursy-app.appspot.com',
    iosClientId: '369199371889-0vpac45n9vgrkglk6qet71bcrinmel17.apps.googleusercontent.com',
    iosBundleId: 'com.drcoderz.toursy',
  );
}
