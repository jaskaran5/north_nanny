import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/logIn/log_in_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogInController>(
      () => LogInController(
        ),
    );
  }
}
