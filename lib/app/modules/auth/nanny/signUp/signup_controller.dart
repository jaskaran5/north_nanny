import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/register_response_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';
import 'package:tuple/tuple.dart';

import '../../../../../navigators/routes_management.dart';
import '../../../../utils/custom_toast.dart';

class SignupViewController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;
  RxString loginType = ''.obs;

  // RxString selectedGender=''.obs;

  RxBool isPasswdVisible = true.obs;
  RxBool isConfirmPasswdVisible = true.obs;

  RxBool isAcceptTerms = false.obs;

  CroppedFile? pickedImage;

  Rxn<LatLng> currentLatLng = Rxn(const LatLng(0, 0));

  @override
  void onInit() async {
    getLoginType();

    super.onInit();
  }

  /// GET LOGIN TYPE
  /// check user type.
  getLoginType() async {
    loginType.value = await Storage.getValue(StringConstants.loginType);

    log("login type is:-->> ${loginType.value}");
    update();
  }

  /// UPDATE SELECTED GENDER
  ///

  /// Show CAMERA and Gallery option
  onClickOnProfilePic() {
    Utility.showImagePicker(
      onGetImage: (image) {
        log("picker image is :-->> ${image.path}");
        pickedImage = image;
        update();
      },
    );
  }

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  updatePasswordVisibility() {
    isPasswdVisible.value = !isPasswdVisible.value;
    update();
  }

  /// confirm password visibility
  updateConfirmPasswordVisibility() {
    isConfirmPasswdVisible.value = !isConfirmPasswdVisible.value;
    update();
  }

  /// ACCEPT TERMS AND CONDITIONS
  toggleIsAcceptTerms(bool? value) {
    isAcceptTerms.value = value ?? false;
    update();
  }

  /// signup validation
  Future<void> registerValidation() async {
    bool isValidate = Validator.instance.signUpValidator(
      emailTextEditingController.text.trim(),
      passwordTextEditingController.text.trim(),
      confirmPasswordTextEditingController.text.trim(),
      isAcceptTerms.value,
    );
    if (isValidate) {
      if (loginType.value == StringConstants.customer) {
        registerApi(type: 1);
      } else {
        registerApi(type: 2);
      }
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// LOCATION CHECK
  Future<void> locationCheck() async {
    if ((Storage.getValue(StringConstants.latitude) ?? 30.7046 == null) ||
        (Storage.getValue(StringConstants.longitude) ?? 76.7179 == null)) {
      Tuple2<LatLng, String>? tuple2 = await Utils.getCurrentLocation();
      if (tuple2 != null) {
        currentLatLng.value = tuple2.item1;
      }
    }
  }

  /// * ------------>>>>>>>>>>>>>>>>> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> REGISTER API <<<<<<<<<<<<<<<<<<<<<<<<<--------

  Future<void> registerApi({required int type}) async {
    if (Storage.hasData(StringConstants.token)) {
      Storage.removeValue(StringConstants.token);
    }

    //  String? deviceToken = await FirebaseMessaging.instance.getToken();
    // final deviceToken = await FirebaseMessaging.instance.getToken() ?? "";
    // log("fcm token : $deviceToken");

    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        "email": emailTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
        "deviceToken": "deviceToken",
        "deviceType": Platform.isAndroid ? "android" : "ios",
        "userType": type,
        // "latitude": Storage.getValue(StringConstants.latitude) ?? 30.7046 ??
        //     currentLatLng.value!.latitude.toString(),
        // "longitude": Storage.getValue(StringConstants.longitude) ?? 76.7179 ??
        //     currentLatLng.value!.longitude.toString()
      };

      printInfo(info: "sign up controller form data: $body");

      _apiHelper.postApi(ApiUrls.customerSignup, body).futureValue((value) {
        var res = RegisterModelResponseJson.fromJson(value);

        if (res.response == AppConstants.apiResponseSuccess) {
          Storage.saveValue(StringConstants.token, res.data!.token);
          toast(msg: res.message!, isError: false);
          if (type == 1) {
            RouteManagement.goToCreateCustomerProfile();
          } else if (type == 2) {
            RouteManagement.goToCreateNannyProfile();
          }
        } else {
          toast(msg: res.message!, isError: true);
        }
      }, onError: (error) {
        toast(msg: error!, isError: true);
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      log("SignUp Api have some issue please check $s ");
    }
  }
}
