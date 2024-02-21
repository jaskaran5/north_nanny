import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_controller.dart';

class DashboardBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardBottomController>(
      () => DashboardBottomController(),
    );
  }
}
