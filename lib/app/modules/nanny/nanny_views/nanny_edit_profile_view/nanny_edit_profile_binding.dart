import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_edit_profile_view/nanny_edit_profile_controller.dart';

class NannyEditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NannyEditProfileController>(
      () => NannyEditProfileController(),
    );
  }
}
