import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';

import '../../../../utils/custom_toast.dart';

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

  updatePswdVisibility() {
    isPasswdVisible.value = !isPasswdVisible.value;
    update();
  }

  /// confirm password visibility
  updateConfirmPswdVisibility() {
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

  /// signup validation
  Future<void> registerValidation() async {
    bool isValidate = Validator.instance.signUpValidator(
      emailTextEditingController.text,
      passwordTextEditingController.text,
      confirmPasswordTextEditingController.text,
      isAcceptTerms.value ,
    );
    if (isValidate) {
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }
}
