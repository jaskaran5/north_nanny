import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_home/nanny_home_controller.dart';

class NannyHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NannyHomeController>(
      () => NannyHomeController(),
    );
  }
}
