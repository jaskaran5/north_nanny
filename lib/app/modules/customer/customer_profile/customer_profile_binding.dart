import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/customer_profile/customer_profile_controller.dart';

class CustomerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerProfileController>(
      () => CustomerProfileController(),
    );
  }
}
