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
    apiKey: 'AIzaSyBsplJG-23hisnxnqimM82CEa9Ist4work',
    appId: '1:621537280145:web:457e7c0e50b6fd821abf30',
    messagingSenderId: '621537280145',
    projectId: 'pringles-44063',
    authDomain: 'pringles-44063.firebaseapp.com',
    storageBucket: 'pringles-44063.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEH7RTwguvI4JhPlJtXUwmT3UqpmOHGZU',
    appId: '1:621537280145:android:20c3215928ded9091abf30',
    messagingSenderId: '621537280145',
    projectId: 'pringles-44063',
    storageBucket: 'pringles-44063.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPyp47MUSrPr84yDyHnrlqT8sV8v9UjvA',
    appId: '1:621537280145:ios:212d944b42da955f1abf30',
    messagingSenderId: '621537280145',
    projectId: 'pringles-44063',
    storageBucket: 'pringles-44063.appspot.com',
    androidClientId: '621537280145-g6i1vpetajpv183t35rgnodootvhm88g.apps.googleusercontent.com',
    iosClientId: '621537280145-bsp5l63r6qt1284ub43opfcaboeu20f0.apps.googleusercontent.com',
    iosBundleId: 'com.example.pringless',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPyp47MUSrPr84yDyHnrlqT8sV8v9UjvA',
    appId: '1:621537280145:ios:212d944b42da955f1abf30',
    messagingSenderId: '621537280145',
    projectId: 'pringles-44063',
    storageBucket: 'pringles-44063.appspot.com',
    androidClientId: '621537280145-g6i1vpetajpv183t35rgnodootvhm88g.apps.googleusercontent.com',
    iosClientId: '621537280145-bsp5l63r6qt1284ub43opfcaboeu20f0.apps.googleusercontent.com',
    iosBundleId: 'com.example.pringless',
  );
}
