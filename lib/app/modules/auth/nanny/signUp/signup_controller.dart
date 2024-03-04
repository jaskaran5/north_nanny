import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/register_response_model.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/customer/customer_views/create_child_profile/child_profile.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/helper.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';

class SignupViewController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;
  RxString loginType = ''.obs;
  String imageUrl = '';

  RxInt currentIndex = 1.obs;

  // RxString selectedGender=''.obs;

  RxBool isPswdVisible = false.obs;
  RxBool isConfirmPswdVisible = false.obs;

  RxBool isAcceptTerms = false.obs;

  RxDouble linearIndicatorDividedValue = 0.0.obs;

  RxInt noOfChild = 1.obs;
  RxDouble linearIndicatorValue = 0.0.obs;
  RxDouble dividedLinearIndicatorValue = 0.0.obs;

  RxString coordinates = "".obs;

  File? pickedImage;

  @override
  void onInit() async {
    getLoginType();

    super.onInit();
  }

  /// GET LOGIN TYPE
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

  /// check box true or false.
  bool? isBoxChecked = false;

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

  updatePswdVisibility() {
    isPswdVisible.value = !isPswdVisible.value;
    update();
  }

  /// confirm password visibility
  updateConfirmPswdVisibility() {
    isConfirmPswdVisible.value = !isConfirmPswdVisible.value;
    update();
  }

  /// ACCEPT TERMS AND CONDITIONS
  toggleIsAcceptTerms() {
    isAcceptTerms.value = !isAcceptTerms.value;
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
      showToast(
        message: Validator.instance.error,
      );
    }
  }

  /// method used to pick the Image from gallery
  // pickImageFromGallery() async {
  //   XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //
  //   if (image != null) {
  //     log("check image is not null -->$editPickedImage");
  //     var file = File(image.path);
  //     editPickedImage = file.path;
  //     update();
  //     log("check image is -->$editPickedImage");
  //   } else {
  //     log("check image is  null -->$editPickedImage");
  //   }
  // }

  updateController() {
    currentIndex++;
    update();
  }

  /// Create Customer profile API=========== >>>>>>>>>>>>>
  createCustomerProfileSignUp() async {
    FormData formData = FormData({
      'Image': pickedImage?.path ?? '',
      "FirstName": firstNameTextEditingController.text.trim(),
      "LastName": lastNameTextEditingController.text.trim(),
      "phoneNumber": phoneNumberTextEditingController.text.trim(),
      "gender": selectedGender == 'Male'
          ? 1
          : selectedGender == "Female"
              ? 2
              : 0,
      "Latitude": firstNameTextEditingController.text.trim(),
      "Logngitude": firstNameTextEditingController.text.trim(),
      "Location": firstNameTextEditingController.text.trim(),
      "ReferralCode": referrelCodeTextEditingController.text.trim()
    });

    _apiHelper.postApi(ApiUrls.customerCreateProfile, formData).futureValue(
        (value) {
      if (value['status'] == 200) {
        var respose = RegisterModelResponseJson.fromJson(value);
      }
    }, retryFunction: () {
      createCustomerProfileSignUp();
    });
  }
}
