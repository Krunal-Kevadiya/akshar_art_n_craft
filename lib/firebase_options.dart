// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      // ignore: no_default_cases
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCqfRJszaL1zZGSsylAgyzwKdkho4KJ2qM',
    appId: '1:341542748178:web:e381287cdd50cd3a5358cb',
    messagingSenderId: '341542748178',
    projectId: 'akshar-art-and-craft',
    authDomain: 'akshar-art-and-craft.firebaseapp.com',
    storageBucket: 'akshar-art-and-craft.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6cLOkMF-e0T0ihQgjmir2bTHfBPHitT8',
    appId: '1:341542748178:android:7ea30806a9ee9e745358cb',
    messagingSenderId: '341542748178',
    projectId: 'akshar-art-and-craft',
    storageBucket: 'akshar-art-and-craft.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCEJSaTG4PRrq9W7UNxddAlXbSuDDDFQbw',
    appId: '1:341542748178:ios:f63ee85b38444a085358cb',
    messagingSenderId: '341542748178',
    projectId: 'akshar-art-and-craft',
    storageBucket: 'akshar-art-and-craft.appspot.com',
    androidClientId:
        '341542748178-prj0cfbhru60vsqebh8eg3d4hltjlc8v.apps.googleusercontent.com',
    iosClientId:
        '341542748178-7qap4cn7cgacc85tk825hcf4gkt3tacv.apps.googleusercontent.com',
    iosBundleId: 'com.akshar.artncraft.aksharArtNCraft',
  );
}
