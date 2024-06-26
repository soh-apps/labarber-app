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
    apiKey: 'AIzaSyAx4UOfv132VYpoWIqD2ju5xlC03M-u23A',
    appId: '1:998357537223:web:128ba4f03fe2dd046709e2',
    messagingSenderId: '998357537223',
    projectId: 'la-barber',
    authDomain: 'la-barber.firebaseapp.com',
    storageBucket: 'la-barber.appspot.com',
    measurementId: 'G-XKDSRFVRE0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgERYQJ5XmNRDKbA3YHoM8LLEJ9kT7uvk',
    appId: '1:998357537223:android:0f73e0de270229e16709e2',
    messagingSenderId: '998357537223',
    projectId: 'la-barber',
    storageBucket: 'la-barber.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7eLsOQLdTPXN9KnBa1kphAFW5ribiEn4',
    appId: '1:998357537223:ios:ef36eb9abe8cd1806709e2',
    messagingSenderId: '998357537223',
    projectId: 'la-barber',
    storageBucket: 'la-barber.appspot.com',
    iosBundleId: 'com.example.laBarber',
  );
}
