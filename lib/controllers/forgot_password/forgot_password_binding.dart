import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/forgot_password/forgot_password.dart';
import 'package:northshore_nanny_flutter/repositories/forgot_password_repository.dart';
import 'package:northshore_nanny_flutter/view_models/forgot_password_view_model.dart';

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
