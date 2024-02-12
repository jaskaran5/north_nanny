import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/logIn/log_in.dart';
import 'package:northshore_nanny_flutter/repositories/repositories.dart';
import 'package:northshore_nanny_flutter/view_models/log_in_view_model.dart';

class LogInViewBinding implements Bindings {
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
