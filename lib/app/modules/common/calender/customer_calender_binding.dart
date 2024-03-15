import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/calender/customer_calender_controller.dart';

class CustomerCalenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerCalenderController>(
      () => CustomerCalenderController(),
    );
  }
}
