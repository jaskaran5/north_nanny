import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/signUp/signup_controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(SignupController.new);
  }
}
