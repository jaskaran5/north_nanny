import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/firebase_options.dart';

import '../../res/constants/string_contants.dart';

class FCMService {
  static final FCMService _fcmService = FCMService._internal();

  factory FCMService() {
    return _fcmService;
  }

  FCMService._internal();

  static late FirebaseMessaging messaging;

  static Future<void> init() async {
    try {
      log("Initializing Firebase...");
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      messaging = FirebaseMessaging.instance;
      log("Firebase initialized.");

      await permissionHandler();
      await setupMessaging();
    } catch (e) {
      log("Error initializing Firebase: $e");
    }
  }

  static Future<bool> permissionHandler() async {
    try {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      log('User granted permission: ${settings.authorizationStatus}');
      return settings.authorizationStatus == AuthorizationStatus.authorized;
    } catch (e) {
      log("Error handling permissions: $e");
      return false;
    }
  }

  static Future<void> setupMessaging() async {
    try {
      String? token = await messaging.getToken();
      log("FCM token: $token");
      if (token != null) {
        Storage.saveValue(StringConstants.fcmToken, token);
      }
    } catch (e) {
      log("Error setting up messaging: $e");
    }
  }

  Future<String> getFCMToken() async {
    try {
      String token = await messaging.getToken() ?? '';
      log('FCM Token: $token');
      return token;
    } catch (e) {
      log("Error getting FCM token: $e");
      return '';
    }
  }

  void showForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Foreground message received: ${message.data}");
      _handleMessageClick(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("Notification clicked in foreground");
      _handleMessageClick(message);
    });
  }

  void _handleMessageClick(RemoteMessage message) {
    log("Handling message click: ${message.data}");
    if (message.data["type"] == "subscriptionSuccess") {
      log("Subscription success message received");
    }
    // Handle notification click event here
  }
}
