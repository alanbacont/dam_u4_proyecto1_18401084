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
    apiKey: 'AIzaSyCOD3bUk-M0EJIn6Xk2KgzGGmDNVHhfu-U',
    appId: '1:331542575408:web:b45f2b2923f382e715b0f5',
    messagingSenderId: '331542575408',
    projectId: 'proyecto1-c6d40',
    authDomain: 'proyecto1-c6d40.firebaseapp.com',
    storageBucket: 'proyecto1-c6d40.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCd4z-rcJLKRUz5g6DwvVI34j0Jt1Uorls',
    appId: '1:331542575408:android:9dcfe2d6ec98629b15b0f5',
    messagingSenderId: '331542575408',
    projectId: 'proyecto1-c6d40',
    storageBucket: 'proyecto1-c6d40.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6QeOPNWKHj_JmKw3-MhLWe4v66U5BogY',
    appId: '1:331542575408:ios:d99182c8ba0017ba15b0f5',
    messagingSenderId: '331542575408',
    projectId: 'proyecto1-c6d40',
    storageBucket: 'proyecto1-c6d40.appspot.com',
    iosClientId: '331542575408-2iqn9927o60dcn0ubicjppldrudmf35g.apps.googleusercontent.com',
    iosBundleId: 'mx.edu.ittepic.damU4Proyecto118401084',
  );
}
