// import 'dart:convert';
// import 'dart:math';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get_utils/src/platform/platform.dart';

// import '../../models/notification_model.dart';

// class NotificationService {
//   //Singleton pattern
//   static final NotificationService _notificationService =
//       NotificationService._internal();
//   static const JsonDecoder _decoder = JsonDecoder();
//   static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

//   factory NotificationService() {
//     return _notificationService;
//   }

//   NotificationService._internal();

//   /// Create a [AndroidNotificationChannel] for heads up notifications
//   AndroidNotificationChannel channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description: 'This channel is used for important notifications.',
//     // description
//     importance: Importance.max,
//   );

//   //instance of FlutterLocalNotificationsPlugin
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<String>? getFcmToken() async {
//     String? fcmToken = await FirebaseMessaging.instance.getToken();
//     return fcmToken != null && fcmToken.isNotEmpty ? fcmToken : '';
//   }

//   Future<void> init() async {
//     await FirebaseMessaging.instance.requestPermission();
//     // _configureSelectNotificationSubject();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );

//     InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       macOS: null,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse:
//           (NotificationResponse notificationResponse) {
//         if (notificationResponse.notificationResponseType ==
//             NotificationResponseType.selectedNotification) {
//           // selectNotificationSubject.add(notificationResponse.payload);
//         }
//       },
//     );

//     /// Create an Android Notification Channel.
//     ///
//     /// We use this channel in the `AndroidManifest.xml` file to override the
//     /// default FCM channel to enable heads up notifications.
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );

//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up notifications.
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     initFirebaseListeners();
//   }

// /*
//   void _configureSelectNotificationSubject() {
//     selectNotificationSubject.stream.listen((String? payload) async {
//       if (fcmToken.isEmpty) {
//         return;
//       }
//       NotificationEntity? entity = convertStringToNotificationEntity(payload);
//       print(
//           "notification _configureSelectNotificationSubject ${entity.toString()}");
//       if (entity != null) {
//         pushNextScreenFromForeground(entity);
//       }
//     });
//   }*/

//   Future? onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     if (getFcmToken() != null) {
//       return null;
//     }
//     NotificationEntity? entity = convertStringToNotificationEntity(payload);
//     debugPrint(
//         "notification onDidReceiveLocalNotification ${entity.toString()}");
//     if (entity != null) {
//       pushNextScreenFromForeground(entity);
//     }
//     return null;
//   }

//   void initFirebaseListeners() {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       if (await getFcmToken() != null) {
//         debugPrint("userToken is Null");
//         return;
//       }

//       debugPrint("IOS Foreground notification opened: ${message.data}");
//       NotificationEntity notificationEntity =
//           NotificationEntity.fromJson(message.data);
//       /*  if(notificationEntity.message == SharedPreferenceHelper().getActiveChatId().toString()){
//         Utils.printLog("active chat id => ${SharedPreferenceHelper().getActiveChatId()} is same");
//         return;
//       }*/
//       pushNextScreenFromForeground(notificationEntity);
//     });
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       // _hitRecentChat();
//       if (GetPlatform.isIOS || await getFcmToken() != null) {
//         return;
//       }
//       debugPrint("Foreground notification received:  ${message.data}");
//       NotificationEntity notificationEntity =
//           NotificationEntity.fromJson(message.data);
//       debugPrint(message.data.toString());
//       notificationEntity.title = notificationEntity.title ?? "NorthShoreNanny";
//       notificationEntity.body = notificationEntity.body;
//       showNotifications(notificationEntity);
//       //  _hitRecentChat();
//     });
//   }

// //   Future? onSelectNotification(String? payload) {
// //     if (fcmToken.isEmpty) {
// //       return null;
// //     }
// //     // NotificationEntity? entity = convertStringToNotificationEntity(payload);
// //     print("notification onSelectNotification ${entity.toString()}");
// //     if (entity != null) {
// //       pushNextScreenFromForeground(entity);
// //     }
// //     return null;
// //   }
// //
// //   void _hitRecentChat() {
// //     if (Get.isRegistered<SocketController>() && localStorage.token != null) {
// //       if (localStorage.islandlordvalue) {
// //         Get.find<SocketController>().recentChat(userType: "landlord");
// //       } else {
// //         if (Get.find<SocketController>().tabIndex == 0) {
// //           Get.find<SocketController>().recentChat(userType: "landlord");
// //         } else {
// //           Get.find<SocketController>().recentChat(userType: "student");
// //         }
// //       }
// //     }
// //   }
// //
//   Future<void> showNotifications(NotificationEntity notificationEntity) async {
//     /*  if(Get.currentRoute==Routes.chat){
//       return;
//     }*/
//     /*  if(notificationEntity.sender_id == SharedPreferenceHelper().getActiveChatId().toString() && notificationEntity.type =="2"){
//       Utils.printLog("active chat id => ${SharedPreferenceHelper().getActiveChatId()} is same");
//       return;
//     }*/
//     Random random = Random();
//     int id = random.nextInt(900) + 10;
//     await flutterLocalNotificationsPlugin.show(
//         id,
//         notificationEntity.title,
//         notificationEntity.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             channelDescription: channel.description,
//             icon: "@mipmap/ic_launcher",
//             channelShowBadge: true,
//             playSound: true,
//             priority: Priority.high,
//             importance: Importance.high,
//             styleInformation: BigTextStyleInformation(notificationEntity.body!),
//           ),
//         ),
//         payload: convertNotificationEntityToString(notificationEntity));
//   }

//   void pushNextScreenFromForeground(
//       NotificationEntity notificationEntity) async {
//     // Tuple2<String, Object>? tuple2 = await callApi(notificationEntity);
//     // print("current active screen ${Get.currentRoute}");
//     // if (tuple2 != null) {
//     //   if (tuple2.item1 == "Chat") {
//     //      final senderName = "";
//     //       final image = "";
//     //       final senderId ="";
//     //         if (localStorage.islandlordvalue) {
//     //         Get.to(MessagesPage(
//     //           senderId: int.parse(senderId),
//     //           senderName: senderName,
//     //           senderImage: image,
//     //         ));
//     //       } else {
//     //         Get.to(StudentMessageScreen(
//     //           senderId: int.parse(senderId),
//     //           senderName: senderName,
//     //           senderImage: image,
//     //         ));
//     //       }
//     //   }
//     /* if (Get.currentRoute == Routes.bottomNav) {
//         if(Get.isRegistered<BottomNavController>()){
//           final bottomController= Get.find<BottomNavController>();
//           if(bottomController.currentIndex.value != 4 && tuple2.item2=="journal"){
//             bottomController.currentIndex.value =4;
//             Get.find<BottomNavController>().changeTabIndex(bottomController.currentIndex.value);
//           }else if (bottomController.currentIndex.value != 3 && tuple2.item2=="habit"){
//             bottomController.currentIndex.value =3;
//             Get.find<BottomNavController>().changeTabIndex(bottomController.currentIndex.value);

//           }
//           return;
//         }
//       }else{
//         Get.toNamed(tuple2.item1, arguments: tuple2.item2);
//       }*/
//   }
// //   Future<Tuple2<String, Object>?> callApi(NotificationEntity entity) async {
// //     print("fdshfdgsfhdsfhdsbf");
// //     switch (entity.notificationTypeId) {
// //       case "Chat":
// //       /*
// // StudentMessageScreen
// //                senderId: int.parse(senderId),
// //                                         senderName: senderName,
// //                                         senderImage: senderImage,
// //
// //                                           final int senderId;
// //   final String senderName;
// //   final String senderImage;
// //
// //   MessagesPage == landLoard
// //
// //       */
// //         log("fdshfdgsfhdsfhdsbf ${entity.toJson()}");
// //         return const Tuple2<String, Object>("Chat", "Chat");
// //       case "journal":
// //         return const Tuple2<String, Object>("Routes.bottomNav", "journal");
// //       case "habit":
// //         return Tuple2<String, Object>("Routes.bottomNav", "habit");
// //       default:
// //         return Tuple2<String, Object>("Routes.bottomNav", "");
// //     }
// //   }
// //
// //   Future<Tuple2<String, Object>?> getPushNotificationRoute() async {
// //     RemoteMessage? remoteMessage =
// //     await FirebaseMessaging.instance.getInitialMessage();
// //     //   final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
// //     const NotificationAppLaunchDetails? notificationAppLaunchDetails = null;
// //     NotificationEntity? entity;
// //     if (remoteMessage != null && remoteMessage.data.isNotEmpty) {
// //       print("RemoteMessage data  ${remoteMessage.data}");
// //       NotificationEntity notificationEntity =
// //       NotificationEntity.fromJson(remoteMessage.data);
// //       entity = NotificationEntity();
// //       entity.title = remoteMessage.data['title'];
// //       entity.body = remoteMessage.data['body'];
// //       entity.type = remoteMessage.data['type'];
// //       return await callApi(notificationEntity);
// //     } else if (notificationAppLaunchDetails != null &&
// //         notificationAppLaunchDetails.didNotificationLaunchApp == true) {
// //       NotificationEntity? entity = convertStringToNotificationEntity(
// //           notificationAppLaunchDetails.notificationResponse?.payload);
// //       if (entity != null) {
// //         print("RemoteMessage data ${entity.toJson()}");
// //         return await callApi(entity);
// //       } else {
// //         return null;
// //       }
// //     } else {
// //       return null;
// //     }
// //   }

//   String convertNotificationEntityToString(
//       NotificationEntity? notificationEntity) {
//     String value = _encoder.convert(notificationEntity);
//     return value;
//   }

//   NotificationEntity? convertStringToNotificationEntity(String? value) {
//     if (value == null) {
//       return null;
//     }
//     Map<String, dynamic> map = _decoder.convert(value);
//     return NotificationEntity.fromJson(map);
//   }
// }
