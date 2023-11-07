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
    apiKey: 'AIzaSyCASskL3IRb7RiuaZJ6eQCWOmy5JXvnXlo',
    appId: '1:623668213874:web:9c826adaef1ad265882aeb',
    messagingSenderId: '623668213874',
    projectId: 'shopapp-3a2a6',
    authDomain: 'shopapp-3a2a6.firebaseapp.com',
    storageBucket: 'shopapp-3a2a6.appspot.com',
    measurementId: 'G-RPEE8VXJE7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARl6lsiB8UqDDdiBK5xbZEkE0vVxzIJdk',
    appId: '1:623668213874:android:8cde7c9c877445bb882aeb',
    messagingSenderId: '623668213874',
    projectId: 'shopapp-3a2a6',
    storageBucket: 'shopapp-3a2a6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEStB0-PNLOxiGGQDAFntEZB-2-SoOn0o',
    appId: '1:623668213874:ios:06d2b235aaad1b0a882aeb',
    messagingSenderId: '623668213874',
    projectId: 'shopapp-3a2a6',
    storageBucket: 'shopapp-3a2a6.appspot.com',
    iosBundleId: 'com.example.shopApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAEStB0-PNLOxiGGQDAFntEZB-2-SoOn0o',
    appId: '1:623668213874:ios:6015178367995d8b882aeb',
    messagingSenderId: '623668213874',
    projectId: 'shopapp-3a2a6',
    storageBucket: 'shopapp-3a2a6.appspot.com',
    iosBundleId: 'com.example.shopApp.RunnerTests',
  );
}
