import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class LocalNotificationService {
  //Todo: implements controller to singleTon
  static final LocalNotificationService _localNotificationService =
      LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _localNotificationService;
  }

  LocalNotificationService._internal();

  //Todo: implements initialized plugin of localNotification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //Todo: created init function to initialized in main.dart
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

  //TODO: ON_SELECT_NOTIFICATION_[selectNotification]
  Future selectNotification(String? message) async {
    //Todo:Handle notification tapped logic here
    log('=========> Notification Clicked - ${message.toString()}');
    var data = jsonDecode(message!);
    if (data["type"] == "newMessage") {}
  }

  /// TODO: ON_RECEIVE_NOTIFICATION_[onDidReceiveLocalNotification]
  void onDidReceiveLocalNotification(
      int id, String? payload, String? payload1, String? payload2) async {
    //Todo:Handle notification logic here
  }

  showNotification({
    int id = 123,
    String? title,
    String? message,
    String? image,
    Map<String, dynamic>? payload,
  }) async {
    //Todo:Create channel specifics for android
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'Cash_Crop',
      'Cash Crop',
      channelDescription: 'Cash Crop Channel',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    //Todo:create platform channel specifics
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      //Todo: iOS: iOSPlatformChannelSpecifics,
    );

    //Todo:show notification
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
        AndroidNotificationDetails('Boome_Influencer', 'Boome Influencer',
            channelDescription: 'Boome Influencer Channel',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            styleInformation: bigPictureStyleInformation);

    //Todo:Image for iOS

    //Todo:Create channel specifics for iOS
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    //Todo:Create Notification detail
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    //Todo:Show notification
    await flutterLocalNotificationsPlugin.show(
        id, title, message, platformChannelSpecifics);
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    //Todo:Convert image url to byte array
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }
}
