import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/parents/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
          //   HomeViewModel(
          //     HomeRepository(),
          //   ),
          ),
    );
  }
}
