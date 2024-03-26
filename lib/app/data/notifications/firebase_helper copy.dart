import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../firebase_options.dart';

class FCMService {
  static final FCMService _fcmService = FCMService._internal();

  factory FCMService() {
    return _fcmService;
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FCMService._internal();

  // FirebaseMessaging? _messaging;

  ///TODO:
  ///[@Firebase_initialized]
  // init() {
  //   _messaging = FirebaseMessaging.instance;

  // }

  static late FirebaseMessaging messaging;

  Future<void> init() async {
    log("Firebasee helperrrr");
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    messaging = FirebaseMessaging.instance;

    await permissionHandler().then((authorized) async {
      log("IS AUTHORIZED:  $authorized");

      setupMessaging();
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

  Future<void> setupMessaging() async {
    await messaging.getToken().then((token) async {
      log("fcm token is :--->> $token");

      await showForGroundMessage();
      // Storage.saveValue(Constants.deviceToken, token);

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
      //TODO: SAVING_FIREBASE_TOKEN_TO_LOCAL_STORAGE
      // AppLocalDb().setFirebaseToken(token);
    });
    print('============FCM Token ---> $token');
    return token;
  }

  ///TODO
  showForGroundMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      log("----------------------->>>>>>>.mesage ------>>>>${message.notification!.body}");
      print('body: ${message.notification!.body.toString()}');
      print('title:${message.notification!.title.toString()}');
      final data = message.data;
      print('notifcation data -------->>>>>>>> $data');
      // _handleMessageClick(message);

      _showNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("notification click in forground");
      // _handleMessageClick(message);

      _showNotification(message);
    });
  }

  ///Todo: handle click
  _handleMessageClick(RemoteMessage message) {
    ///Handle all message notification click
    print("====>newMessage${message.data.toString()}");
    if (message.data["type"] == "subcriptionSuccess") {
      print("====>newMessage${message.data.toString()}");
    }
    // print('=========> Notification Clicked - ${message.toString()}');

    ///TODo: handle notification click event here
  }

  Future<void> _showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      message.senderId ?? '',
      'your channel name',
      channelDescription: 'your channel description',
      icon: "@drawable/ic_notification",
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(152, message.notification?.title,
        message.notification?.body ?? '', notificationDetails,
        payload: message.data.toString());
  }
}
