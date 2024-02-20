import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/view_models/log_in_view_model.dart';

class LogInController extends GetxController {
  LogInController(this.logInViewModel);

  final LogInViewModel logInViewModel;

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  /// to check remember me enable or disable.
  bool? isRememberMe = false;
}
