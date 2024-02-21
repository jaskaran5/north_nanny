import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/calender/calender_controller.dart';

class CalenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalenderController>(
      () => CalenderController(),
    );
  }
}
