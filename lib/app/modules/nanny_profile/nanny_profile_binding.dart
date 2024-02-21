import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny_profile/nanny_profile_controller.dart';

class NannyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NannyProfileController>(
      () => NannyProfileController(),
    );
  }
}
