import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/chat_notification_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/notification_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/common/notification/notification_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/notification/notification_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/customer_home_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/customer_home_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/nanny_home_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/nanny_home_controller.dart';
import 'package:northshore_nanny_flutter/navigators/app_routes.dart';

import '../../../firebase_options.dart';
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
        defaultPresentSound: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        requestProvisionalPermission: true);
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
      provisional: true,
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
      log("notification messages is type-->> ${message.data["Type"]}");
      log("----------------------->>>>>>>.message ------>>>>${message.notification!.body}");
      log('body: ${message.notification?.body.toString()}');
      log('title:${message.notification?.title.toString()}');
      final data = message.data;
      log('notification data -------->>>>>>>> $data');
//
      if (message.data["Type"] != null) {
        log("currenr route is -->> ${Get.currentRoute}");
        debugPrint("currenr route is -->> ${Get.currentRoute}");

        if (Get.currentRoute != Routes.chat) {
          showChatNotification(message);
        }
      } else {
        showNotification(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("notification click in foreground");
      if (message.data["Type"] != null) {
        if (Get.currentRoute != Routes.chat) {
          showChatNotification(message);
        }
      } else {
        showNotification(message);
      }
    });
  }

  /// used to show the notifications.
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      message.senderId ?? '',
      'The Northshore Nanny',
      channelDescription: 'the nanny channel description',
      icon: "@drawable/ic_notification",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    DarwinNotificationDetails drawinNotificationDetail =
        const DarwinNotificationDetails(
            presentAlert: true, presentSound: true, presentBanner: true);

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
    await dashBoardBottomController.getNotificationCount().then((value) {
      log("get notification api called in firebase helper");
    });

    /// used to get the notification list in notification view.
    if (!Get.isRegistered<NotificationController>()) {
      NotificationBinding().dependencies();
    }

    Get.find<NotificationController>().getNotificationList();

    if (logInType == StringConstants.customer) {
      if (!Get.isRegistered<BookingDetailController>()) {
        BookingDetailBinding().dependencies();
      }

      /// used to  get the booking detail.
      Get.find<BookingDetailController>().getBookingDataById(
          bookingId: int.parse(response.bookingId.toString()));

      if (dashBoardBottomController.selectedTabIndex.value == 0) {
        if (!Get.isRegistered<CustomerHomeController>()) {
          CustomerHomeBinding().dependencies();
        }
        var customerHomeController = Get.find<CustomerHomeController>();

        /// used to get customer list .
        customerHomeController.getDashboardApi();
      }
    } else if (logInType == StringConstants.nanny) {
      if (!Get.isRegistered<NannyBookingDetailController>()) {
        NannyBookingDetailBinding().dependencies();
      }

      /// used to get booking detail.
      Get.find<NannyBookingDetailController>().getBookingDetailOfCustomer(
          bookingId: int.parse(response.bookingId ?? ''));

      /// call if index ==0,
      if (dashBoardBottomController.selectedTabIndex.value == 0) {
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

  /// used to show --->>>>> CHAT <<<<<<<-------    the notifications.
  Future<void> showChatNotification(RemoteMessage message) async {
    log("show chat notification -->> ${message.data}");
    log("show chat notification -->> ${message.data}");
    log("show chat notification -->> ${message.data}");
    log("show chat notification -->> ${message.data}");

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      message.senderId ?? '',
      'The Northshore Nanny',
      channelDescription: 'nanny channel description',
      icon: "@drawable/ic_notification",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    DarwinNotificationDetails drawinNotificationDetail =
        const DarwinNotificationDetails(presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: drawinNotificationDetail);

    /// this is used to convert notification
    var response = ChatNotificationResponseModel.fromJson(message.data);

    log('notification response data :$response');

    var logInType = Storage.getValue(StringConstants.loginType);
    log('Notification Login Type------------> $logInType');

    // this code os used to show the local notification in app.
    await flutterLocalNotificationsPlugin.show(
      int.parse(response.type.toString()),
      response.title,
      response.body ?? '',
      notificationDetails,
      payload: message.data.toString(),
    );
    debugPrint('notification showing');
  }

  /// used to on tap notification handle
  void selectNotification(NotificationResponse notificationResponse) async {
    debugPrint('Notification Tapped payload :${notificationResponse.payload}');

    // if (notificationResponse.P = null) {
    // } else {
    String payload = "${notificationResponse.payload}";

    debugPrint('Notification Tapped payload-->> :$payload');

    // Remove curly braces and split the string by comma followed by space
    List<String> keyValuePairs =
        payload.substring(1, payload.length - 1).split(', ');

    // Create an empty map to store key-value pairs
    Map<String, String> resultMap = {};

    // Iterate through the key-value pairs
    for (String pair in keyValuePairs) {
      // Split each pair by colon
      List<String> parts = pair.split(': ');

      // Extract key and value (removing leading and trailing spaces, and enclosing quotes if any)
      String key = parts[0].trim();
      String value = parts[1].trim().replaceAll(
          RegExp(r'^"|"$'), ''); // Remove enclosing quotes if present

      // Add key-value pair to the map
      resultMap[key] = value;
    }
//
    // Print the resulting map
    debugPrint("result map$resultMap");

    String userId = Storage.getValue(StringConstants.userId).toString();

    if (resultMap.containsKey("Type")) {
      String senderId = resultMap["SenderId"].toString();
      String receiverId = resultMap["ReciverId"].toString();

      if (userId.toString() == senderId) {
        Get.toNamed(Routes.chat,
            arguments: (receiverId == 'null' ||
                    receiverId == 'Null' ||
                    receiverId.isEmpty)
                ? ''
                : receiverId);
      } else if (userId.toString() == receiverId) {
        Get.toNamed(Routes.chat,
            arguments:
                (senderId == 'null' || senderId == 'Null' || senderId.isEmpty)
                    ? ''
                    : senderId);
      }
    } else {
      /// used to paras the response.
      var response = parseNotificationModel(payload);

      debugPrint('Notification Tap response: ${response.toJson()}');
      String logInType = await Storage.getValue(StringConstants.loginType);

      debugPrint(
          'Notification Tap LogIn Type :$logInType  and  response $response');

      var controller = Get.find<DashboardBottomController>();
      controller.selectedBottomTab = 2;
      controller.getNotificationCount();
      Future.delayed(
        const Duration(seconds: 4),
        () => controller.update(),
      );
    }

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
    // }
  }

  /// used to on tap notification handle
  void selecChattNotification(NotificationResponse notificationResponse) async {
    debugPrint('Notification Tapped payload :${notificationResponse.payload}');
    String payload = "${notificationResponse.payload}";

    /// used to paras the response.
    var response = parseNotificationModel(payload);

    debugPrint('Notification Tap response: $response');
    String logInType = await Storage.getValue(StringConstants.loginType);

    debugPrint(
        'Notification Tap LogIn Type :$logInType  and  response $response');
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

  /// this is used to convert the response of model to this.
  ChatNotificationResponseModel parseChatNotificationModel(String data) {
    // Convert the string to valid JSON format
    data = data.replaceAllMapped(RegExp(r'(\b\w+\b)(?=:)', multiLine: true),
        (Match match) => '"${match.group(0)}"');
    data = data.replaceAll(':', '":');

    // Parse the JSON string into a map
    Map<String, dynamic> map = jsonDecode('{$data}');

    debugPrint(map.toString());

    // Extract values from the map and create a NotificationModel instance
    return ChatNotificationResponseModel(
      body: map['body'] ?? '',
      type: map['Type'],
      reciverId: map['ReciverId'],
      senderImage: map['SenderImage'],
      senderName: map['SenderName'],
      title: map['title'],
      senderId: map['SenderId'],
    );
  }
}

/// used to show background messages.
Future<void> showBackgroundNotification(RemoteMessage message) async {
  log('Background notification :${message.data}');

  if (message.data["Type"] != null) {
    FCMService().showChatNotification(message);
  } else {
    FCMService().showNotification(message);
  }
}
