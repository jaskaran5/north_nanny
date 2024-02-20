import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/view_models/forgot_password_view_model.dart';

class ForgotPasswordController extends GetxController {
  ForgotPasswordController(this.forgotPasswordViewModel);
  final ForgotPasswordViewModel forgotPasswordViewModel;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController otpTextEditingController = TextEditingController();
  TextEditingController newPasswordTextEditingController =
      TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
}
