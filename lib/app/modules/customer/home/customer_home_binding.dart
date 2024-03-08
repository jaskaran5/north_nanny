import 'package:get/get.dart';

import 'customer_home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerHomeController>(
      () => CustomerHomeController(),
    );
  }
}
