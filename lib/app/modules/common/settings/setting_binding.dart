import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
  }
}
