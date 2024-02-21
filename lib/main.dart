import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_values.dart';
import 'package:northshore_nanny_flutter/navigators/app_pages.dart';

import 'app/data/local/db_wrapper.dart';

void main() async {
  await _setup();
  runApp(const MyApp());
}

//
Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(DBWrapper());
  // Get.put(DeviceConfig()).init();
  // Get.lazyPut(SharedPreferencesManager.new);
  // await Future.wait([
  //   AppConfig.init(
  //     const EnvConfig(
  //       appTitle: AppConstants.appName,
  //       appFlavor: AppFlavor.dev,
  //     ),
  //   ),
  //   Get.put<DBWrapper>(DBWrapper()),
  // ]);
  // Get.put<ApiWrapper>(ApiWrapper());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setTheSystemOrientation();
  }

  /// used to set app orientation.
  setTheSystemOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('en'),
          theme: ThemeData(
            useMaterial3: false,
            scaffoldBackgroundColor: Colors.white,
          ),
          translations: TranslationsFile(),
          getPages: AppPages.pages,
          initialRoute: AppPages.initial,
        ),
      );
}
