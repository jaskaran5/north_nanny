import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/helper.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';

class LogInController extends GetxController {
  String loginType = '';

  RxBool isPswdVisible = false.obs;
  RxBool rememberMe = false.obs;

  @override
  void onInit() {
    checkLoginType();

    // checkIsNanny();
    super.onInit();
  }

  checkLoginType() {
    loginType = Storage.getValue(StringConstants.loginType);
    update();
  }

  /// ---------- TOOGLE  PASSWORD----------
  togglePassword() {
    isPswdVisible.value = !isPswdVisible.value;
    update();
  }

  /// ---------- TOOGLE  REMEMBER ME----------
  toggleRememberMe({val}) {
    rememberMe.value = val;
    update();
  }

  // bool? isNannyView;
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  /// to check remember me enable or disable.
  bool? isRememberMe = false;

  Future<void> onClickOnLogin() async {
    bool valid = Validator.instance.loginValidator(
        emailTextEditingController.text.trim(),
        passwordTextEditingController.text.trim());

    if (valid) {
      await loginApi();
    } else {
      showToast(
        message: Validator.instance.error,
      );
    }
  }

  loginApi() {}
}
