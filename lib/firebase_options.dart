// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBDf4m-orsIwfdlJQ8rtOpKn2lzGAa6ZcM',
    appId: '1:949456432128:web:20850381a81ffde173bce5',
    messagingSenderId: '949456432128',
    projectId: 'flutter-burc-rehberi-e9ada',
    authDomain: 'flutter-burc-rehberi-e9ada.firebaseapp.com',
    storageBucket: 'flutter-burc-rehberi-e9ada.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASASS1Bsl0iqr-S5oXV1kfIxg2mbSLutQ',
    appId: '1:949456432128:android:f1f6d1fcbc4c2d0a73bce5',
    messagingSenderId: '949456432128',
    projectId: 'flutter-burc-rehberi-e9ada',
    storageBucket: 'flutter-burc-rehberi-e9ada.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaznVXwU6ylhEoIttIXjnmHiL5xt3I0eo',
    appId: '1:949456432128:ios:d4e6b9fab1bcf1f473bce5',
    messagingSenderId: '949456432128',
    projectId: 'flutter-burc-rehberi-e9ada',
    storageBucket: 'flutter-burc-rehberi-e9ada.appspot.com',
    iosClientId: '949456432128-sp48bkljc952r3tcui5aheoh697s81rq.apps.googleusercontent.com',
    iosBundleId: 'com.example.burcRehberi',
  );
}
