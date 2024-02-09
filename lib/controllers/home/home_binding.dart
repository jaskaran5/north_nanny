import 'package:get/get.dart';

import '../../repositories/repositories.dart';
import '../../view_models/view_models.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        HomeViewModel(
          HomeRepository(),
        ),
      ),
    );
  }
}
