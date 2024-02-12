import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/view_models/sign_up_view_model.dart';

class SignupViewController extends GetxController {
  SignupViewController(this.signUpViewModel);

  final SignUpViewModel signUpViewModel;

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  /// check box true or false.
  bool? isBoxChecked = false;
}
