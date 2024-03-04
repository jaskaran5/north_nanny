import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';

import '../../../navigators/routes_management.dart';
import '../../res/constants/assets.dart';
import '../../res/theme/styles.dart';
import '../../utils/translations/translation_keys.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController otpTextEditingController = TextEditingController();
  TextEditingController newPasswordTextEditingController =
      TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  int otpLength = 4;
  bool isVisibleNewPassword = true;
  bool isVisibleConfirmPassword = true;

  /// email validator
  emailValidator() {
    bool isValidate = Validator.instance
        .forgotPasswordValidator(emailTextEditingController.text.trim());
    if (isValidate) {
      otpTextEditingController.clear();
      RouteManagement.goToEmailVerification();
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// otp validator
  otpValidator() {
    Get.focusScope?.unfocus();
    if (otpTextEditingController.text.length != otpLength) {
      toast(msg: 'Please Enter otp', isError: true);
    } else {
      newPasswordTextEditingController.clear();
      confirmPasswordTextEditingController.clear();
      RouteManagement.goToCreateNewPassword();
    }
  }

  /// used to store the value of new Password visible
  void isNewPasswordVisible() {
    isVisibleNewPassword = !isVisibleNewPassword;
    update();
  }

  /// used to store the value of Confirm Password visible
  void isConfirmPasswordVisible() {
    isVisibleConfirmPassword = !isVisibleConfirmPassword;
    update();
  }

  /// Change Password validator
  changePasswordValidator() {
    bool isValidate = Validator.instance.changePasswordValidator(
      newPassword: newPasswordTextEditingController.text.trim(),
      confirmPassword: confirmPasswordTextEditingController.text.trim(),
    );
    if (isValidate) {
      Get.focusScope?.unfocus();
      RouteManagement.goToSuccessView(
        buttonText: TranslationKeys.backToLogIn.tr,
        successSvg: Assets.iconsSuccess,
        header: TranslationKeys.passwordChanged.tr,
        headerStyle: AppStyles.ubDarkBlackColor26W700,
        subHeader: TranslationKeys.passwordChangeSuccess.tr,
        onTapButton: () {
          RouteManagement.goToOffAllLogIn();
        },
        subTitleStyle: AppStyles.ubGreyA116W500,
        subHeaderMaxLines: 2,
        headerMaxLines: 1,
        successImage: '',
        sendTipText: false,
      );
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }
}
