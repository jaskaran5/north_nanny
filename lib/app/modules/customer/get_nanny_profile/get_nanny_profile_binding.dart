import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/get_nanny_profile/get_nanny_profile_controller.dart';

class GetNannyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetNannyProfileController>(
      () => GetNannyProfileController(),
    );
  }
}
