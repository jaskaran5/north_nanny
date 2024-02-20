import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/filter_view/filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterController>(() => FilterController());
  }
}
