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

  /// used to initialize the firebase notifications.
  static Future<void> init() async {
    log("Firebase helper ");
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    messaging = FirebaseMessaging.instance;

    await permissionHandler().then((authorized) async {
      log("IS AUTHORIZED:  $authorized");
      if (authorized) {
        await setupMessaging();
      }
    });
  }

  static Future<bool> permissionHandler() async {
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
  }

  static Future<void> setupMessaging() async {
    await messaging.getToken().then((token) async {
      log("fcm token is :--->> $token");

      Storage.saveValue(StringConstants.fcmToken, token);

      // final session = locator<Session>();
      // logMe("firebase-token: $token");
      // session.setFcmToken = token!;
    });
    // await incomingNotificationHandling();
  }

  Future<String> getFCMToken() async {
    String token = '';
    await messaging.getToken().then((value) {
      token = value!;

      /// SAVING_FIREBASE_TOKEN_TO_LOCAL_STORAGE
      // AppLocalDb().setFirebaseToken(token);
    });
    log('============FCM Token ---> $token');
    return token;
  }

  ///TODO
  showForGroundMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      log(message.notification!.body.toString());
      log(message.notification!.title.toString());
      _handleMessageClick(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("notification click in forground");
      _handleMessageClick(message);
    });
  }

  //// handle click
  _handleMessageClick(RemoteMessage message) {
    ///Handle all message notification click
    log("====>newMessage${message.data.toString()}");
    if (message.data["type"] == "subcriptionSuccess") {
      log("====>newMessage${message.data.toString()}");
    }
    // print('=========> Notification Clicked - ${message.toString()}');

    //// handle notification click event here
  }
}
