import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';

import '../../../../../navigators/routes_management.dart';
import '../../../../utils/custom_toast.dart';
import '../../../../utils/validators.dart';

class SignupViewController extends GetxController {
  RxString loginType = ''.obs;
  String imageUrl = '';

  RxBool isPasswdVisible = true.obs;
  RxBool isConfirmPasswdVisible = true.obs;

  RxBool isAcceptTerms = false.obs;

  RxInt noOfChild = 1.obs;
  RxDouble linearIndicatorValue = 0.0.obs;

  @override
  void onInit() async {
    getLoginType();

    super.onInit();
  }

  /// check user type.
  getLoginType() async {
    loginType.value = await Storage.getValue(StringConstants.loginType);

    log("login type is:-->> ${loginType.value}");
    update();
  }

  /// UPDATE NO OF CHILDREN
  updateNoOfChildren({val}) {
    noOfChild.value = val;

    updateLinearIndicator();
    update();
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
  updateLinearIndicator() {
    linearIndicatorValue.value =
        double.parse((1 / noOfChild.value).toStringAsFixed(3));
    update();

    log("linear indicator value is :-->> ${linearIndicatorValue.value}");
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
        RouteManagement.goToCreateCustomerProfile();
      } else {
        RouteManagement.goToCreateNannyProfile();
      }
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }
}
