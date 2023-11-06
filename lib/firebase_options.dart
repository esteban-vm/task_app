import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

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
    apiKey: 'AIzaSyCbgPZVXjLdaJB3yiknOy1fzGzuii5nlpo',
    appId: '1:342903579532:web:530cdd33f9ed79b6d52ca9',
    messagingSenderId: '342903579532',
    projectId: 'task-app-aa99f',
    authDomain: 'task-app-aa99f.firebaseapp.com',
    storageBucket: 'task-app-aa99f.appspot.com',
    measurementId: 'G-PHB8PYWTLQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAiG4WNQHHPSNsYgzWr8e4LNW9LQj9qYUw',
    appId: '1:342903579532:android:0de3d07d74a3fd4dd52ca9',
    messagingSenderId: '342903579532',
    projectId: 'task-app-aa99f',
    storageBucket: 'task-app-aa99f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAI2jHVXzaN6O4uiKXn4b-xQK-cMSF-A0',
    appId: '1:342903579532:ios:a853a2e558905db0d52ca9',
    messagingSenderId: '342903579532',
    projectId: 'task-app-aa99f',
    storageBucket: 'task-app-aa99f.appspot.com',
    iosBundleId: 'com.example.taskApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDAI2jHVXzaN6O4uiKXn4b-xQK-cMSF-A0',
    appId: '1:342903579532:ios:5ee13e7cd220d88bd52ca9',
    messagingSenderId: '342903579532',
    projectId: 'task-app-aa99f',
    storageBucket: 'task-app-aa99f.appspot.com',
    iosBundleId: 'com.example.taskApp.RunnerTests',
  );
}