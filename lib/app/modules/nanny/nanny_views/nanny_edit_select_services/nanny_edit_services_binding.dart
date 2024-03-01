import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_edit_select_services/nanny_edit_services_controller.dart';

class NannyEditSelectServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NannyEditSelectServicesController>(
      () => NannyEditSelectServicesController(),
    );
  }
}
