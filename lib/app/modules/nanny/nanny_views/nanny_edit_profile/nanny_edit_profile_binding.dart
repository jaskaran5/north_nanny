import 'package:get/get.dart';

import 'nanny_edit_profile_controller.dart';

class NannyEditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NannyEditProfileController>(
      () => NannyEditProfileController(),
    );
  }
}
