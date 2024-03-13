import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/customer_login_response_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

import '../../../../data/api/api_helper.dart';
import '../../../../models/login_response_model.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../utils/app_utils.dart';

class LogInController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;
  String loginType = '';

  bool isPasswordVisible = true;
  RxBool rememberMe = false.obs;

  @override
  void onInit() {
    checkLoginType();
    super.onInit();
    checkSavedSession();
  }

  checkAndRemoveAuthToken() {
    if (Storage.hasData(StringConstants.token)) {
      log("has token-----");
      Storage.removeValue(StringConstants.token);
    } else {
      log("doesnt have auth token======");
    }
  }

  /// SAVE REMEMBER ME DATA
  saveRememberMeValue() {
    if (rememberMe.value) {
      Storage.saveValue(
          StringConstants.email, emailTextEditingController.text.trim());
      Storage.saveValue(
          StringConstants.pswd, passwordTextEditingController.text.trim());
    } else {
      Storage.removeValue(
        StringConstants.email,
      );
      Storage.removeValue(StringConstants.pswd);
    }
  }

  checkSavedSession() {
    if (Storage.hasData(StringConstants.email)) {
      rememberMe.value = true;
      emailTextEditingController.text = Storage.getValue(StringConstants.email);
      passwordTextEditingController.text =
          Storage.getValue(StringConstants.pswd);
      update();
    }
  }

  /// check user Type.
  checkLoginType() {
    loginType = Storage.getValue(StringConstants.loginType);

    update();
  }

  /// ---------- TOOGLE  PASSWORD----------
  togglePassword() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  /// ---------- TOOGLE  REMEMBER ME----------
  toggleRememberMe({val}) {
    rememberMe.value = val;
    update();
  }

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  /// to check remember me enable or disable.
  bool? isRememberMe = false;

  /// log in validation.
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

  /// log in api for nanny and customer.
  loginApi({required int userType}) async {
    if (Storage.hasData(StringConstants.token)) {
      Storage.removeValue(StringConstants.token);
    }
    try {
      // final deviceToken = await FirebaseMessaging.instance.getToken() ?? "";
      // log("fcm token : $deviceToken");
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        "email": emailTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
        "deviceToken": "deviceToken",
        "deviceType": Platform.isAndroid ? "android" : "ios",
        "userType": userType,
        "latitude":
            Storage.getValue(StringConstants.latitude) ?? 30.7046.toString(),
        "longitude":
            Storage.getValue(StringConstants.longitude) ?? 76.7179.toString(),
      };

      printInfo(info: "login up controller form data: $body");

      _apiHelper.postApi(ApiUrls.customerLogin, body).futureValue((value) {
        saveRememberMeValue();
        if (userType == 2) {
          /******* NANNY ----------->>>>>>>> */
          var res = LoginResponseDataModel.fromJson(value);
          if (res.response == AppConstants.apiResponseSuccess) {
            Storage.saveValue(StringConstants.token, res.data!.token);
            if (res.data?.user?.isProfileCreated == false) {
              RouteManagement.goToCreateNannyProfile();
            } else if (res.data?.user?.isServicesCreated == false) {
              RouteManagement.goToSelectServicesView();
            } else if (res.data?.user?.isBankDetailAdded == false &&
                res.data?.user?.isSkipBankDetail == false) {
              RouteManagement.goToBankDetailView();
            }
            // else if (res.data?.user?.isApproved == false ||
            //     res.data?.user?.isSkipBankDetail == true) {
            //   RouteManagement.goToOffAllWaitingApprovalView();
            // }
            else {
              Storage.saveValue(StringConstants.isLogin, true);

              RouteManagement.goToOffAllDashboard(isFromSetting: false);
            }
            toast(msg: res.message.toString(), isError: false);
          } else {
            toast(msg: res.message.toString(), isError: true);
          }
        } else if (userType == 1) {
          /******* CUSTOMER ----------->>>>>>>> */
          var res = CustomerLoginResponseModel.fromJson(value);

          log("login response : $res");

          if (res.response == AppConstants.apiResponseSuccess) {
            Storage.saveValue(StringConstants.token, res.data?.token);
            if (res.data?.user?.isProfileCreated == false) {
              /** PROFILE is not created */

              RouteManagement.goToCreateCustomerProfile();
            } else {
              if (res.data?.user?.isSkipChildDetails == true) {
                Storage.saveValue(StringConstants.isLogin, true);
                RouteManagement.goToOffAllDashboard(isFromSetting: false);
              } else if (res.data?.user?.isChildAdded == false) {
                RouteManagement.goToChooseChildProfileView();
              } else if (res.data?.user?.isChildAdded == true) {
                Storage.saveValue(StringConstants.isLogin, true);
                RouteManagement.goToOffAllDashboard(isFromSetting: false);
              }
            }
          } else {
            toast(msg: res.message!, isError: true);
          }
        }
      }, onError: (error) {
        toast(msg: error.toString(), isError: true);
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      log("LogIn Api have some issue please check $s ");
    }
  }
}
