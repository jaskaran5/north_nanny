import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/customer/customer_views/create_child_profile/create_child_profile_controller.dart';

class CreateChildProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateChildProfileController>(
      () => CreateChildProfileController(),
    );
  }
}
