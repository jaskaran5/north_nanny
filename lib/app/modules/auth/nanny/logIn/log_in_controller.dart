import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';

class LogInController extends GetxController {
  String loginType = '';
  @override
  void onInit() {
    checkLoginType();

    // checkIsNanny();
    super.onInit();
  }
  /// check user Type.
  checkLoginType() {
    loginType = Storage.getValue(StringConstants.loginType);
    update();
  }

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  /// to check remember me enable or disable.
  bool? isRememberMe = false;

  Future<void> onClickOnLogin() async {
    bool valid = Validator.instance.loginValidator(
        emailTextEditingController.text.trim(),
        passwordTextEditingController.text.trim());

    // if (valid) {
    //   await loginApi();
    // } else {
    //   toast(msg: Validator.instance.error, isError: true);
    // }
  }
}
