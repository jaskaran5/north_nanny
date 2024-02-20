import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/logIn/log_in_controller.dart';
import 'package:northshore_nanny_flutter/app/repositories/log_in_repository.dart';
import 'package:northshore_nanny_flutter/app/view_models/log_in_view_model.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogInController>(
      () => LogInController(
        LogInViewModel(
          LogInRepository(),
        ),
      ),
    );
  }
}
