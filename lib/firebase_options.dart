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
    apiKey: 'AIzaSyDrriKWHYyglHRZKeFjarX3ibxOk6MAnXg',
    appId: '1:590743930409:web:a22f4ce65a40866e9bbe38',
    messagingSenderId: '590743930409',
    projectId: 'hook-9f781',
    authDomain: 'hook-9f781.firebaseapp.com',
    storageBucket: 'hook-9f781.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAF6ofwiDKfz2gui_MNokkLUHGQNoDxFGo',
    appId: '1:590743930409:android:db9032168cd0b4a49bbe38',
    messagingSenderId: '590743930409',
    projectId: 'hook-9f781',
    storageBucket: 'hook-9f781.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA95v66d75gMwnPnTsy9lwwMxrSC0sEgpY',
    appId: '1:590743930409:ios:439c647bdd42bb2b9bbe38',
    messagingSenderId: '590743930409',
    projectId: 'hook-9f781',
    storageBucket: 'hook-9f781.appspot.com',
    iosBundleId: 'com.example.hook',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA95v66d75gMwnPnTsy9lwwMxrSC0sEgpY',
    appId: '1:590743930409:ios:bf9c9960e51854959bbe38',
    messagingSenderId: '590743930409',
    projectId: 'hook-9f781',
    storageBucket: 'hook-9f781.appspot.com',
    iosBundleId: 'com.example.hook.RunnerTests',
  );
}