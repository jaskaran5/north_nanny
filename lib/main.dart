import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:northshore_nanny_flutter/app/utils/initializers.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_values.dart';
import 'package:northshore_nanny_flutter/navigators/app_pages.dart';

import 'app/data/notifications/notification_services.dart';

void main() async {
  await _setup();
  runApp(const MyApp());
}

/// used to setup the storage and notification things.
Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// used to initialize the firebase on app.
  await Firebase.initializeApp();

  /// used to initialize the  firebase messaging.
  await NotificationService().init();

  /// used to initialize the local storage.
  await GetStorage.init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // void initState() {
  //   socketConnection();

  //   super.initState();
  // }

  // socketConnection() async {
  //   final signalRHelper = SignalRHelper();
  //   await signalRHelper.init();
  // }

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: GetMaterialApp(
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          locale: const Locale('en'),
          theme: ThemeData(
            useMaterial3: false,
            scaffoldBackgroundColor: Colors.white,
          ),
          translations: TranslationsFile(),
          getPages: AppPages.pages,
          initialRoute: AppPages.initial,
          initialBinding: InitialBindings(),
        ),
      );
}
