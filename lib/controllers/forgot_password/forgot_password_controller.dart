import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/view_models/forgot_password_view_model.dart';

class ForgotPasswordController extends GetxController {
  ForgotPasswordController(this.forgotPasswordViewModel);
  final ForgotPasswordViewModel forgotPasswordViewModel;
  final emailTextEditingController = TextEditingController();
  final otpTextEditingController = TextEditingController();
  final newPasswordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();
}
