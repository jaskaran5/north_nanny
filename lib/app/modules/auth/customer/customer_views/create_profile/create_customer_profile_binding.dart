import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/customer/customer_views/create_profile/create_customer_profile_controller.dart';

class CreateChildProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateCustomerProfileController>(
      () => CreateCustomerProfileController(),
    );
  }
}
