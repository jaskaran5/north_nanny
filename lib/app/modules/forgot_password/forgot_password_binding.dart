import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:northshore_nanny_flutter/app/repositories/forgot_password_repository.dart';
import 'package:northshore_nanny_flutter/app/view_models/forgot_password_view_model.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(
        ForgotPasswordViewModel(
          ForgotPasswordRepository(),
        ),
      ),
    );
  }
}
