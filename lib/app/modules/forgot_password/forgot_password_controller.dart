import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';

import '../../../navigators/routes_management.dart';
import '../../data/api/api_helper.dart';
import '../../models/add_payment_response_model.dart';
import '../../models/register_response_model.dart';
import '../../res/constants/api_urls.dart';
import '../../res/constants/app_constants.dart';
import '../../res/constants/assets.dart';
import '../../res/theme/styles.dart';
import '../../utils/app_utils.dart';
import '../../utils/translations/translation_keys.dart';

class ForgotPasswordController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;
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
      postOtpApi(isComeFromResend: false);
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// post otp api to get otp
  Future<void> postOtpApi({required bool isComeFromResend}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        'email': emailTextEditingController.text.trim(),
      };

      log("get otp body :$body");

      _apiHelper.postApi(ApiUrls.forgotPassword, body).futureValue((value) {
        printInfo(info: "Forgot Password response value $value");
        var response = RegisterModelResponseJson.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          if (!isComeFromResend) {
            otpTextEditingController.clear();
            RouteManagement.goToEmailVerification();
          }
          toast(msg: response.message.toString(), isError: false);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "forgot password get   API ISSUE $s");
    }
  }

  /// verify otp api
  Future<void> verifyOtp() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        'otp': otpTextEditingController.text.trim(),
      };

      log("Verify Otp :$body");

      _apiHelper.postApi(ApiUrls.verifyOtp, body).futureValue((value) {
        printInfo(info: "Verify Otp response value $value");
        var response = AddPaymentMethodModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          newPasswordTextEditingController.clear();
          confirmPasswordTextEditingController.clear();
          RouteManagement.goToCreateNewPassword();
          toast(msg: response.message.toString(), isError: false);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Verify Otp   API ISSUE $s");
    }
  }

  /// otp validator
  otpValidator() {
    Get.focusScope?.unfocus();
    if (otpTextEditingController.text.length != otpLength) {
      toast(msg: 'Please Enter otp', isError: true);
    } else {
      verifyOtp();
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
      resetPassword();
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// reset password api
  Future<void> resetPassword() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        'newPassword': newPasswordTextEditingController.text.trim(),
        'email': emailTextEditingController.text.trim(),
      };

      log("Reset Password :$body");

      _apiHelper.postApi(ApiUrls.resetPassWord, body).futureValue((value) {
        printInfo(info: "Reset Password response value $value");
        var response = RegisterModelResponseJson.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
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
          toast(msg: response.message.toString(), isError: false);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Reset Password API ISSUE $s");
    }
  }
}
