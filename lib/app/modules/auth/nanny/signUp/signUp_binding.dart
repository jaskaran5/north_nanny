import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/signUp/signup_controller.dart';
import 'package:northshore_nanny_flutter/app/repositories/sign_up_repository.dart';
import 'package:northshore_nanny_flutter/app/view_models/sign_up_view_model.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupViewController>(
      () => SignupViewController(
        SignUpViewModel(
          SignUpRepository(),
        ),
      ),
    );
  }
}
