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

  /// it is used to make the instance of localNotification.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FCMService._internal();

  static late FirebaseMessaging messaging;

  Future<void> init() async {
    log("Firebase helper");
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    messaging = FirebaseMessaging.instance;
    const String iconNotification = '@drawable/ic_notification';

    const initializationSettingsAndroid =
        AndroidInitializationSettings(iconNotification);

    const darwinInitializationSettings = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestAlertPermission: true,
        requestBadgePermission: true);
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: darwinInitializationSettings);

    /// used to check the notification.
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: selectNotification);

    await permissionHandler().then((authorized) async {
      log("IS AUTHORIZED:  $authorized");
      if (authorized) {
        setupMessaging();
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

  Future<void> setupMessaging() async {
    await messaging.getToken().then((token) async {
      log("fcm token is :--->> $token");
      await showForGroundMessage();
    });
  }

  Future<String> getFCMToken() async {
    String token = '';
    await messaging.getToken().then((value) {
      token = value ?? '';
    });
    log('============FCM Token ---> $token');
    return token;
  }

  ///TODO
  showForGroundMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      log("----------------------->>>>>>>.message ------>>>>${message.notification!.body}");
      log('body: ${message.notification?.body.toString()}');
      log('title:${message.notification?.title.toString()}');
      final data = message.data;
      log('notification data -------->>>>>>>> $data');
      _showNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("notification click in foreground");
      handleMessageClick(message);
    });
  }

  ///Todo: handle click
  handleMessageClick(RemoteMessage message) {
    ///Handle all message notification click
    log("====>newMessage${message.data.toString()}");
    if (message.data["type"] == "subcriptionSuccess") {
      log("====>newMessage${message.data.toString()}");
    }
    // log('=========> Notification Clicked - ${message.toString()}');

    ///TODo: handle notification click event here
  }

  /// used to show the notifications.
  Future<void> _showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      message.senderId ?? '',
      'NorthShoreNanny',
      channelDescription: 'nanny channel description',
      icon: "@drawable/ic_notification",
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    /// this code os used to show the local notification in app.
    await flutterLocalNotificationsPlugin.show(152, message.notification?.title,
        message.notification?.body ?? '', notificationDetails,
        payload: message.data.toString());
  }

  selectNotification(NotificationResponse notificationResponse) {
    log('Notification Tapped:$notificationResponse');
  }
}
