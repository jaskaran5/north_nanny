import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/signUp/signup_controller.dart';


class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupViewController>(
      () => SignupViewController(
      ),
    );
  }
}
