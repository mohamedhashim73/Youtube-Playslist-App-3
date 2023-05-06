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
    apiKey: 'AIzaSyCnkPR9wIqX4mTCR4Pyai3db7CxBAf9roQ',
    appId: '1:648321714259:web:198b59cedc4e2137c11ea6',
    messagingSenderId: '648321714259',
    projectId: 'chat-app-4e9f6',
    authDomain: 'chat-app-4e9f6.firebaseapp.com',
    databaseURL: 'https://chat-app-4e9f6-default-rtdb.firebaseio.com',
    storageBucket: 'chat-app-4e9f6.appspot.com',
    measurementId: 'G-0QS037HM7F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDt1jhapjS66dL3CpyIuy3v_UJ-EqJxxSo',
    appId: '1:648321714259:android:6e65d001c9d1bfecc11ea6',
    messagingSenderId: '648321714259',
    projectId: 'chat-app-4e9f6',
    databaseURL: 'https://chat-app-4e9f6-default-rtdb.firebaseio.com',
    storageBucket: 'chat-app-4e9f6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD2pl961qMzrAp6NWc-lHxCjyu6BSyeTSw',
    appId: '1:648321714259:ios:f00e0a322b762940c11ea6',
    messagingSenderId: '648321714259',
    projectId: 'chat-app-4e9f6',
    databaseURL: 'https://chat-app-4e9f6-default-rtdb.firebaseio.com',
    storageBucket: 'chat-app-4e9f6.appspot.com',
    iosClientId: '648321714259-vstopifa53303oslni8pg6mkhk8t3tcb.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD2pl961qMzrAp6NWc-lHxCjyu6BSyeTSw',
    appId: '1:648321714259:ios:f00e0a322b762940c11ea6',
    messagingSenderId: '648321714259',
    projectId: 'chat-app-4e9f6',
    databaseURL: 'https://chat-app-4e9f6-default-rtdb.firebaseio.com',
    storageBucket: 'chat-app-4e9f6.appspot.com',
    iosClientId: '648321714259-vstopifa53303oslni8pg6mkhk8t3tcb.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}