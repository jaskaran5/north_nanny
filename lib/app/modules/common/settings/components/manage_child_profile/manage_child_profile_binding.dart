import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/components/manage_child_profile/manage_child_profile_controller.dart';

class ManageChildProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageChildProfileController>(
      () => ManageChildProfileController(),
    );
  }
}
