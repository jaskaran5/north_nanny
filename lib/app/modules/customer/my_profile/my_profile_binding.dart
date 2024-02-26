import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/my_profile/my_profile_controller.dart';

class MyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProfileController>(
      () => MyProfileController(),
    );
  }
}
