import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/notification_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/notification/notification_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/notification/notification_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/customer_home_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/customer_home_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/nanny_home_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/nanny_home_controller.dart';

import '../../../firebase_options.dart';
import '../../../navigators/routes_management.dart';
import '../../modules/common/booking_details/booking_detail_binding.dart';
import '../../modules/common/booking_details/booking_detail_controller.dart';
import '../../modules/nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_binding.dart';
import '../../modules/nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_controller.dart';
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
      _showNotification(message);
    });
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

    /// this is used to convert notification
    var response = NotificationEntityModel.fromJson(message.data);

    var logInType = Storage.getValue(StringConstants.loginType);
    log('Notification Login Type------------> $logInType');
    if (logInType == StringConstants.customer) {
      if (!Get.isRegistered<CustomerHomeController>()) {
        CustomerHomeBinding().dependencies();
      }
      var customerHomeController = Get.find<CustomerHomeController>();
      customerHomeController.getDashboardApi();
    } else {
      if (!Get.isRegistered<NannyHomeController>()) {
        NannyHomeBinding().dependencies();
      }
      var nannyHomeController = Get.find<NannyHomeController>();
      nannyHomeController.getHomeData();
    }

    /// this code os used to show the local notification in app.
    await flutterLocalNotificationsPlugin.show(
        response.notificationId ?? 0,
        message.notification?.title,
        message.notification?.body ?? '',
        notificationDetails,
        payload: message.data.toString());
  }

  /// used to on tap notification
  selectNotification(NotificationResponse notificationResponse) {
    log('Notification Tapped payload :${notificationResponse.payload}');

    /// this is used to convert notification
    var response = NotificationEntityModel.fromJson(
        jsonDecode(notificationResponse.payload ?? ''));

    var logInType = Storage.getValue(StringConstants.loginType);

    log('Notification LogIn Type :$logInType  and  response $response');

    if (!Get.isRegistered<NotificationController>()) {
      NotificationBinding().dependencies();
    }

    /// api used to read the notification
    Get.find<NotificationController>()
        .postNotificationRead(notificationId: response.notificationId ?? 0);

    if (logInType == StringConstants.nanny) {
      if (!Get.isRegistered<NannyBookingDetailController>()) {
        NannyBookingDetailBinding().dependencies();
      }
      var nannyBookingDetailsController =
          Get.find<NannyBookingDetailController>();

      /// used to  get the booking detail.
      nannyBookingDetailsController.getBookingDetailOfCustomer(
          bookingId: response.bookingId ?? 0);

      /// used to  store  the booking Status.
      nannyBookingDetailsController.typeOfBooking(
          bookingStatus: response.bookingStatus ?? 0);

      /// going to route.
      RouteManagement.goToNannyBookingView();
    } else if (logInType == StringConstants.customer) {
      if (!Get.isRegistered<BookingDetailController>()) {
        BookingDetailBinding().dependencies();
      }

      /// used to  get the booking detail.
      Get.find<BookingDetailController>()
          .getBookingDataById(bookingId: response.bookingId ?? 0);

      /// used to  store  the booking Status.
      Get.find<BookingDetailController>()
          .typeOfBooking(bookingStatus: response.bookingStatus ?? 0);

      /// going to route.
      RouteManagement.goToCustomerBookingDetailView();
    }
  }
}
