import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/register_response_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
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
  String imageUrl = '';

  RxInt currentIndex = 1.obs;

  // RxString selectedGender=''.obs;

  RxBool isPasswdVisible = true.obs;
  RxBool isConfirmPasswdVisible = true.obs;

  RxBool isAcceptTerms = false.obs;

  RxDouble linearIndicatorDividedValue = 0.0.obs;

  RxInt noOfChild = 1.obs;
  RxDouble linearIndicatorValue = 0.0.obs;
  RxDouble dividedLinearIndicatorValue = 0.0.obs;

  RxString coordinates = "".obs;

  File? pickedImage;

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

  /// UPDATE NO OF CHILDREN
  updateNoOfChildren({val}) {
    noOfChild.value = val;

    updateLinearIndicator().then((value) {
      dividedLinearIndicatorValue.value = linearIndicatorValue.value;

      log("divided: ${dividedLinearIndicatorValue.value}");
      log("linear: ${linearIndicatorValue.value}");
    });
    update();

    log("divide value :-->> ${dividedLinearIndicatorValue.value}");
  }

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
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();
  final noOfChildrenTextEditingController = TextEditingController(text: "1");
  final childNameTextEditingController = TextEditingController();
  final childAgeTextEditingController = TextEditingController();
  final allergiesTextEditingController = TextEditingController();
  final medicalConditionTextEditingController = TextEditingController();
  final anyThingTextEditingController = TextEditingController();
  final referrelCodeTextEditingController = TextEditingController();

  /// gender list.
  List<String> genderList = GenderConstant.values
      .map((e) => e.genderName.capitalizeFirst.toString())
      .toList();

  /// selected Gender
  String? selectedGender = '';

  /// storeGenderValue
  void setGenderValue(String gender) {
    selectedGender = gender;
    update();
  }

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

  /// UPDATE LINER INDICATOR
  Future<void> updateLinearIndicator() async {
    linearIndicatorValue.value =
        double.parse((1 / noOfChild.value).toStringAsFixed(3));

    update();

    log("linear indicator value is :-->> ${linearIndicatorValue.value}");
  }

  updateLinearIndicatorValueWhenDataFilled() {
    linearIndicatorValue.value += dividedLinearIndicatorValue.value;

    update();
  }

  /// CUSTOMER SIGN UP VALIDATION----------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> customerSignUpValidation() async {
    bool valid = Validator.instance.customerCreateProfileValidator(
      firstName: firstNameTextEditingController.text.trim(),
      lastName: lastNameTextEditingController.text.trim(),
      coordinates:
          coordinates.value.isEmpty ? '0.0' : coordinates.value.toString(),
      phoneNumber: phoneNumberTextEditingController.text.trim(),
    );
    if (valid) {
      createCustomerProfileSignUp();
      // Get.to(
      //   const ChildProfileView(),
      // );

      /// sign up api
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  updateController() {
    currentIndex++;
    update();
  }

  /// Create Customer profile API=========== >>>>>>>>>>>>>
  Future<void> createCustomerProfileSignUp() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      FormData body = FormData({
        if (pickedImage != null)
          'Image': MultipartFile(pickedImage!.path,
              filename: pickedImage!.path.split('/').last),

        "FirstName": firstNameTextEditingController.text.trim(),
        "LastName": lastNameTextEditingController.text.trim(),
        "phoneNumber": phoneNumberTextEditingController.text.trim(),
        "gender": selectedGender == 'Male'
            ? 1
            : selectedGender == "Female"
                ? 2
                : 0,
        "Latitude":
            locationTextEditingController.text.split(',').first.toString(),
        "Logngitude":
            locationTextEditingController.text.split(',').last.toString(),
        // "Location": firstNameTextEditingController.text.trim(),
        "ReferralCode": referrelCodeTextEditingController.text.trim()
      });

      log(body.fields.toString());
      log("auth token:-->> ${Storage.getValue(StringConstants.token)}");

      _apiHelper.postApi(ApiUrls.customerCreateProfile, body).futureValue(
          (value) {
        printInfo(info: "create customer profile response value $value");

        // if (value['status'] == 200) {
        //   var respose = RegisterModelResponseJson.fromJson(value);
        // }
      }, retryFunction: () {
        createCustomerProfileSignUp();
      });
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "CREATE PROFILE API ISSUE $s");
    }
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
    if ((Storage.getValue(StringConstants.latitude) == null) ||
        (Storage.getValue(StringConstants.longitude) == null)) {
      Tuple2<LatLng, String>? tuple2 = await Utils.getCurrentLocation();
      if (tuple2 != null) {
        currentLatLng.value = tuple2.item1;
      }
    }
  }

  /// * ------------>>>>>>>>>>>>>>>>> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> REGISTER API <<<<<<<<<<<<<<<<<<<<<<<<<--------

  Future<void> registerApi({required int type}) async {   if (Storage.hasData(StringConstants.token)) {
    Storage.removeValue(StringConstants.token);
  }



    //  String? deviceToken = await FirebaseMessaging.instance.getToken();
    String deviceToken = 'devicetokenfirebaseneeded';

    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        "email": emailTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
        "deviceToken": deviceToken,
        "deviceType": Platform.isAndroid ? "android" : "ios",
        "userType": type,
        // "latitude": Storage.getValue(StringConstants.latitude) ??
        //     currentLatLng.value!.latitude.toString(),
        // "longitude": Storage.getValue(StringConstants.longitude) ??
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

  /// -------->>>>>>>>>> UPDATE LOCATION <<<<<<<<<<---------
  Future<void> updateLocationTextField({required String position}) async {
    locationTextEditingController.text = position;
    update();
  }
}
