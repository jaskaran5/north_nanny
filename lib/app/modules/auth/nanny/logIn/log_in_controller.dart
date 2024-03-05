import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

import '../../../../data/api/api_helper.dart';
import '../../../../models/login_response_model.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../utils/app_utils.dart';

class LogInController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;
  String loginType = '';

  RxBool isPasswordVisible = false.obs;
  RxBool rememberMe = false.obs;

  @override
  void onInit() {
    checkLoginType();
    checkAndRemoveAuthToken();

    // checkIsNanny();
    super.onInit();
  }

  checkAndRemoveAuthToken() {
    if (Storage.hasData(StringConstants.token)) {
      log("has token-----");
      Storage.removeValue(StringConstants.token);
    } else {
      log("doesnt have auth token======");
    }
  }

  /// check user Type.
  checkLoginType() {
    loginType = Storage.getValue(StringConstants.loginType);
    update();
  }

  /// ---------- TOOGLE  PASSWORD----------
  togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
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
      if (loginType == StringConstants.customer) {
        await loginApi(userType: 1);
      } else {
        await loginApi(userType: 2);
      }
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  loginApi({required int userType}) async {
    if (Storage.hasData(StringConstants.token)) {
      Storage.removeValue(StringConstants.token);
    }
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        "email": emailTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
        "deviceToken": 'nskkhdndniud',
        "deviceType": Platform.isAndroid ? "android" : "ios",
        "userType": userType,
        "latitude": Storage.getValue(StringConstants.latitude).toString(),
        "longitude": Storage.getValue(StringConstants.longitude).toString(),
      };

      printInfo(info: "login up controller form data: $body");

      _apiHelper.postApi(ApiUrls.customerLogin, body).futureValue((value) {
        var res = LoginResponseDataModel.fromJson(value);
        if (res.response == AppConstants.apiResponseSuccess) {
          Storage.saveValue(StringConstants.token, res.data!.token);
          if (res.data?.user?.userType == 1) {
          } else if (res.data?.user?.userType == 2) {
            if (res.data?.user?.isProfileCreated == false) {
              RouteManagement.goToCreateNannyProfile();
            } else if (res.data?.user?.isServicesCreated == false) {
              RouteManagement.goToSelectServicesView();
            } else if (res.data?.user?.isBankDetailAdded == false &&
                res.data?.user?.isSkipBankDetail == false) {
              RouteManagement.goToBankDetailView();
            } else if (res.data?.user?.isApproved == false ||
                res.data?.user?.isSkipBankDetail == true) {
              RouteManagement.goToOffAllWaitingApprovalView();
            } else {
              RouteManagement.goToOffAllDashboard(isFromSetting: false);
            }
          }
          toast(msg: res.message!, isError: false);
        } else {
          toast(msg: res.message!, isError: true);
        }
      }, onError: (error) {
        toast(msg: error!, isError: true);
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      log("LogIn Api have some issue please check $s ");
    }
  }
}
