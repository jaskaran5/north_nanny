import 'package:get/get.dart';

import 'package:northshore_nanny_flutter/app/modules/splash/splash_view_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );

  }
}
