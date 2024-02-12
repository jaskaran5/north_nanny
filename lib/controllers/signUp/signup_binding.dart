import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/signUp/signup_controller.dart';
import 'package:northshore_nanny_flutter/repositories/repositories.dart';
import 'package:northshore_nanny_flutter/view_models/sign_up_view_model.dart';

class SignUpViewBinding implements Bindings {
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
