import 'package:firebase_messaging/firebase_messaging.dart';

import 'model/token.dart';

class PushNotificationsManager {
  PushNotificationsManager._();
  Token _token;

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      _token.token = token;
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }
}
