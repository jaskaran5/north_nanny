import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/notification_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/customer_home_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/customer_home_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/nanny_home_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/nanny_home_controller.dart';

import '../../../firebase_options.dart';
import '../../res/constants/string_contants.dart';

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

    const darwinInitializationSettings = DarwinInitializationSettings();
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

  ///used to show the notification.
  showForGroundMessage() {
    /// used to show background messages.
    FirebaseMessaging.onBackgroundMessage(showBackgroundNotification);

    /// used to listen the notification.
    FirebaseMessaging.onMessage.listen((message) {
      log("----------------------->>>>>>>.message ------>>>>${message.notification!.body}");
      log('body: ${message.notification?.body.toString()}');
      log('title:${message.notification?.title.toString()}');
      final data = message.data;
      log('notification data -------->>>>>>>> $data');
      showNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("notification click in foreground");
      showNotification(message);
    });
  }

  /// used to show the notifications.
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      message.senderId ?? '',
      'NorthShoreNanny',
      channelDescription: 'nanny channel description',
      icon: "@drawable/ic_notification",
      importance: Importance.max,
      priority: Priority.max,
    );

    DarwinNotificationDetails drawinNotificationDetail =
        const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: drawinNotificationDetail);

    /// this is used to convert notification
    var response = NotificationEntityModel.fromJson(message.data);

    log('notification response data :$response');

    var logInType = Storage.getValue(StringConstants.loginType);
    log('Notification Login Type------------> $logInType');

    if (!Get.isRegistered<DashboardBottomController>()) {
      DashboardBottomBinding().dependencies();
    }

    var dashBoardBottomController = Get.find<DashboardBottomController>();
    dashBoardBottomController.getNotificationCount();
    if (dashBoardBottomController.selectedTabIndex.value == 0) {
      if (logInType == StringConstants.customer) {
        if (!Get.isRegistered<CustomerHomeController>()) {
          CustomerHomeBinding().dependencies();
        }
        var customerHomeController = Get.find<CustomerHomeController>();

        /// used to get customer list .
        customerHomeController.getDashboardApi();
      } else if (logInType == StringConstants.nanny) {
        if (!Get.isRegistered<NannyHomeController>()) {
          NannyHomeBinding().dependencies();
        }
        var nannyHomeController = Get.find<NannyHomeController>();
        nannyHomeController.getHomeData();
      }
    }

    /// this code os used to show the local notification in app.
    await flutterLocalNotificationsPlugin.show(
      int.parse(response.notificationId ?? '0'),
      message.notification?.title,
      message.notification?.body ?? '',
      notificationDetails,
      payload: message.data.toString(),
    );
    debugPrint('notification showing');
  }

  /// used to on tap notification handle
  void selectNotification(NotificationResponse notificationResponse) async {
    debugPrint('Notification Tapped payload :${notificationResponse.payload}');
    String payload = "${notificationResponse.payload}";

    /// used to paras the response.
    var response = parseNotificationModel(payload);

    debugPrint('Notification Tap response: $response');
    String logInType = await Storage.getValue(StringConstants.loginType);

    debugPrint(
        'Notification Tap LogIn Type :$logInType  and  response $response');

    var controller = Get.find<DashboardBottomController>();
    controller.selectedBottomTab = 2;
    Future.delayed(
      const Duration(seconds: 1),
      () => controller.update(),
    );

    /// this code is used to redirect to the booking flow when we tap on that.
    /*

    /// api used to read the notification
    Get.find<NotificationController>().postNotificationRead(
        notificationId: int.parse(response.notificationId.toString()));

    if (logInType == StringConstants.nanny) {
      if (!Get.isRegistered<NannyBookingDetailController>()) {
        NannyBookingDetailBinding().dependencies();
      }
      var nannyBookingDetailsController =
          Get.find<NannyBookingDetailController>();

      /// used to  get the booking detail.
      nannyBookingDetailsController.getBookingDetailOfCustomer(
          bookingId: int.parse(response.bookingId.toString()));

      /// used to  store  the booking Status.
      nannyBookingDetailsController.typeOfBooking(
          bookingStatus: int.parse(response.bookingStatus.toString()));

      /// going to route.
      RouteManagement.goToNannyBookingView();
    } else if (logInType == StringConstants.customer) {
      if (!Get.isRegistered<BookingDetailController>()) {
        BookingDetailBinding().dependencies();
      }

      /// used to  get the booking detail.
      Get.find<BookingDetailController>().getBookingDataById(
          bookingId: int.parse(response.bookingId.toString()));

      /// used to  store  the booking Status.
      Get.find<BookingDetailController>().typeOfBooking(
          bookingStatus: int.parse(response.bookingStatus.toString()));

      /// going to route.
      RouteManagement.goToCustomerBookingDetailView();
    }*/
  }

  /// this is used to convert the response of model to this.
  NotificationEntityModel parseNotificationModel(String data) {
    // Remove curly braces and split by commas to get key-value pairs
    List<String> keyValuePairs =
        data.replaceAll('{', '').replaceAll('}', '').split(',');

    // Create a map to store key-value pairs
    Map<String, String> keyValueMap = {};
    for (String pair in keyValuePairs) {
      List<String> keyValue = pair.trim().split(':');
      if (keyValue.length == 2) {
        keyValueMap[keyValue[0].trim()] = keyValue[1].trim();
      }
    }
    DateTime datetime = DateTime.now();
    if (keyValueMap.containsKey('datetime')) {
      String datetimeStr = keyValueMap['datetime'] ?? "";
      // Split date and time components
      List<String> components = datetimeStr.split(' ');
      // Parse date and time
      String dateStr = components[0];
      String timeStr = '${components[1]} ${components[2]}';
      datetime = DateTime.parse('$dateStr $timeStr');
    }
    // Extract values from the map and create a NotificationModel instance
    return NotificationEntityModel(
      datetime: datetime.toString(),
      bookingStatus: keyValueMap['bookingstatus'] ?? "",
      notificationType: keyValueMap['notificationtype'] ?? "",
      notificationId: keyValueMap['notificationid'] ?? "",
      body: keyValueMap['body'] ?? "",
      title: keyValueMap['title'] ?? "",
      bookingId: keyValueMap['bookingid'] ?? "",
    );
  }
}

/// used to show background messages.
Future<void> showBackgroundNotification(RemoteMessage message) async {
  log('Background notification :$message');
  FCMService().showNotification(message);
}
