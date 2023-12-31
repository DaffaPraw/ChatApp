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
    apiKey: 'AIzaSyBHl3r8cX2GMsoO_ZOFywTZvf1iTSy9pXk',
    appId: '1:1071886061520:web:203d42a317fb020aed73d5',
    messagingSenderId: '1071886061520',
    projectId: 'chatapp-dfdd5',
    authDomain: 'chatapp-dfdd5.firebaseapp.com',
    storageBucket: 'chatapp-dfdd5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDweAvQNEK3XDCG4sANor3PbUNKXJR7dkc',
    appId: '1:1071886061520:android:c37a72e08d006d8ced73d5',
    messagingSenderId: '1071886061520',
    projectId: 'chatapp-dfdd5',
    storageBucket: 'chatapp-dfdd5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQrpx44MM6i34TrEL-QeJ3aGNSCzqA6kA',
    appId: '1:1071886061520:ios:9a6d631690b611e6ed73d5',
    messagingSenderId: '1071886061520',
    projectId: 'chatapp-dfdd5',
    storageBucket: 'chatapp-dfdd5.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQrpx44MM6i34TrEL-QeJ3aGNSCzqA6kA',
    appId: '1:1071886061520:ios:f9dc22756a3cbe29ed73d5',
    messagingSenderId: '1071886061520',
    projectId: 'chatapp-dfdd5',
    storageBucket: 'chatapp-dfdd5.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}
