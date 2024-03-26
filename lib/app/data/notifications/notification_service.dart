import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class LocalNotificationService {
  /// implements controller to singleTon
  static final LocalNotificationService _localNotificationService =
      LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _localNotificationService;
  }

  LocalNotificationService._internal();

  /// implements initialized plugin of localNotification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// created init function to initialized in main.dart
  init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: selectNotification
      onDidReceiveNotificationResponse: (details) {
        log(details.toString());
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
        log("background :$details");
      },
    );

    /*final bool result =*/
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  /// ON_SELECT_NOTIFICATION_[selectNotification]
  Future selectNotification(String? message) async {
    ///Handle notification tapped logic here
    log('=========> Notification Clicked - ${message.toString()}');
    var data = jsonDecode(message!);
    if (data["type"] == "newMessage") {}
  }

  /// / ON_RECEIVE_NOTIFICATION_[onDidReceiveLocalNotification]
  void onDidReceiveLocalNotification(
      int id, String? payload, String? payload1, String? payload2) async {
    ///Handle notification logic here
  }

  showNotification({
    int id = 123,
    String? title,
    String? message,
    String? image,
    Map<String, dynamic>? payload,
  }) async {
    ///Create channel specifics for android
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'Northshore nanny',
      'Northshore nanny',
      channelDescription: 'Northshore nanny Channel',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    ///create platform channel specifics
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,

      /// iOS: iOSPlatformChannelSpecifics,
    );

    ///show notification
    await flutterLocalNotificationsPlugin.show(
        id, title, message, platformChannelSpecifics,
        payload: json.encode(payload));
  }

  Future<void> showBigPictureNotification({
    int id = 123,
    String? title,
    String? message,
    String? image,
    String? payload,
  }) async {
    final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
      await _getByteArrayFromUrl(
        image!,
      ),
    );
    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
      await _getByteArrayFromUrl(
        image,
      ),
    );

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      bigPicture,
      largeIcon: largeIcon,
      // contentTitle: 'overridden <b>big</b> content title',
      htmlFormatContentTitle: true,
      // summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true,
    );

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('Northshore nanny', 'Northshore nanny',
            channelDescription: 'Nothshore nanny',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            styleInformation: bigPictureStyleInformation);

    ///Image for iOS

    ///Create channel specifics for iOS
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    ///Create Notification detail
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    ///Show notification
    await flutterLocalNotificationsPlugin.show(
        id, title, message, platformChannelSpecifics);
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    ///Convert image url to byte array
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }
}
