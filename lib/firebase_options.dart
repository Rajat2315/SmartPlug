// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCkmetH5ghuNnoH2B6_MI4uoYDx6-tQVzE',
    appId: '1:825525843669:web:de18757edcfd80532b945c',
    messagingSenderId: '825525843669',
    projectId: 'ecoplugauth',
    authDomain: 'ecoplugauth.firebaseapp.com',
    storageBucket: 'ecoplugauth.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbxkBdes0xx_epC8vNvh8bGjbNmo8RIQg',
    appId: '1:825525843669:android:bc9b331b041322da2b945c',
    messagingSenderId: '825525843669',
    projectId: 'ecoplugauth',
    storageBucket: 'ecoplugauth.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDW4APRYEvoeDnO_dPn52xoUsfr1oAA9hs',
    appId: '1:825525843669:ios:491c5006539534cb2b945c',
    messagingSenderId: '825525843669',
    projectId: 'ecoplugauth',
    storageBucket: 'ecoplugauth.firebasestorage.app',
    androidClientId: '825525843669-uhpn07etfm4u7pt5vqt1b4m7d68v6toa.apps.googleusercontent.com',
    iosClientId: '825525843669-52mdbggkki0cgnnntpi0ig72ovtgbu80.apps.googleusercontent.com',
    iosBundleId: 'com.example.authtest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDW4APRYEvoeDnO_dPn52xoUsfr1oAA9hs',
    appId: '1:825525843669:ios:491c5006539534cb2b945c',
    messagingSenderId: '825525843669',
    projectId: 'ecoplugauth',
    storageBucket: 'ecoplugauth.firebasestorage.app',
    androidClientId: '825525843669-uhpn07etfm4u7pt5vqt1b4m7d68v6toa.apps.googleusercontent.com',
    iosClientId: '825525843669-52mdbggkki0cgnnntpi0ig72ovtgbu80.apps.googleusercontent.com',
    iosBundleId: 'com.example.authtest',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCkmetH5ghuNnoH2B6_MI4uoYDx6-tQVzE',
    appId: '1:825525843669:web:7e014f23630133c12b945c',
    messagingSenderId: '825525843669',
    projectId: 'ecoplugauth',
    authDomain: 'ecoplugauth.firebaseapp.com',
    storageBucket: 'ecoplugauth.firebasestorage.app',
  );

}