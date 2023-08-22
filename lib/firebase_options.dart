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
    apiKey: 'AIzaSyAF3q4Fpd6zvWO4anOW-HL8sEoMMlBBcGM',
    appId: '1:613773475148:web:538a7002e2089561efa3e9',
    messagingSenderId: '613773475148',
    projectId: 'qrinfo-4e117',
    authDomain: 'qrinfo-4e117.firebaseapp.com',
    storageBucket: 'qrinfo-4e117.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArIJE_rTshXcfJofmZ_CSSriqUp4mroZg',
    appId: '1:613773475148:android:bd0274c796799438efa3e9',
    messagingSenderId: '613773475148',
    projectId: 'qrinfo-4e117',
    storageBucket: 'qrinfo-4e117.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDhyHPOJpwzJUd2ZiH5zH4qV7UskhbOaqc',
    appId: '1:613773475148:ios:860187e42a853378efa3e9',
    messagingSenderId: '613773475148',
    projectId: 'qrinfo-4e117',
    storageBucket: 'qrinfo-4e117.appspot.com',
    iosClientId: '613773475148-otrb6qessjkc7tdakr775vdkieq7n2ik.apps.googleusercontent.com',
    iosBundleId: 'com.example.qrinfo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDhyHPOJpwzJUd2ZiH5zH4qV7UskhbOaqc',
    appId: '1:613773475148:ios:d6aeb58433e9bce9efa3e9',
    messagingSenderId: '613773475148',
    projectId: 'qrinfo-4e117',
    storageBucket: 'qrinfo-4e117.appspot.com',
    iosClientId: '613773475148-qc12c7oim738qlo2l3t5eju8o89s509s.apps.googleusercontent.com',
    iosBundleId: 'com.example.qrinfo.RunnerTests',
  );
}
