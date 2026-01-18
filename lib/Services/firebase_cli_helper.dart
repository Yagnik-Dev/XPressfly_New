import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDpozbt9Wm8Tn5CSebx68q24ZVGvoDu0Ew',
    appId: '1:293452707394:android:d8fbfa8635f0d303e65fdb',
    messagingSenderId: '293452707394',
    projectId: 'xpressfly-9efa8',
    // storageBucket: 'YOUR_STORAGE_BUCKET',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDc3F_Wh11Opr3sSzKVM7gjiREXMhcUQRE',
    appId: '1:293452707394:ios:cb462b5a6f9235b4e65fdb',
    messagingSenderId: '293452707394',
    projectId: 'xpressfly-9efa8',
    storageBucket: 'xpressfly-9efa8.firebasestorage.app',
  );

  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return android;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return ios;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }
}
