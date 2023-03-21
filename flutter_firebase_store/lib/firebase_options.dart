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
        return macos;
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
    apiKey: 'AIzaSyAhxhLjuk_ZH6Sv71Ng1P9jqTjxG9qylfQ',
    appId: '1:814979498151:web:6011a78491a371f28b1b82',
    messagingSenderId: '814979498151',
    projectId: 'firestore-learning-377a6',
    authDomain: 'firestore-learning-377a6.firebaseapp.com',
    storageBucket: 'firestore-learning-377a6.appspot.com',
    measurementId: 'G-01N6HCWVVL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2TZkJqL92NDx-f_Ws9tpJW3rvBGZWtzU',
    appId: '1:814979498151:android:f5fe932875416c678b1b82',
    messagingSenderId: '814979498151',
    projectId: 'firestore-learning-377a6',
    storageBucket: 'firestore-learning-377a6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAM2MKT8SMcli0TQJLms15YPrPyj0ah1bk',
    appId: '1:814979498151:ios:c6026544621a3fb78b1b82',
    messagingSenderId: '814979498151',
    projectId: 'firestore-learning-377a6',
    storageBucket: 'firestore-learning-377a6.appspot.com',
    iosClientId: '814979498151-om2g51be54udh0nhefu3adib59ag5ddm.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebaseStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAM2MKT8SMcli0TQJLms15YPrPyj0ah1bk',
    appId: '1:814979498151:ios:c6026544621a3fb78b1b82',
    messagingSenderId: '814979498151',
    projectId: 'firestore-learning-377a6',
    storageBucket: 'firestore-learning-377a6.appspot.com',
    iosClientId: '814979498151-om2g51be54udh0nhefu3adib59ag5ddm.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebaseStore',
  );
}
