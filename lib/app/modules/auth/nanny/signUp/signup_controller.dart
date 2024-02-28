import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';

class SignupViewController extends GetxController {
  RxString loginType = ''.obs;
  String imageUrl = '';

  RxBool isPswdVisible = false.obs;
  RxBool isConfirmPswdVisible = false.obs;

  RxBool isAcceptTerms = false.obs;

  @override
  void onInit() async {
    getLoginType();

    super.onInit();
  }

  getLoginType() async {
    loginType.value = await Storage.getValue(StringConstants.loginType);

    log("login type is:-->> ${loginType.value}");
    update();
  }

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();
  final noOfChildrenTextEditingController = TextEditingController();
  final childNameTextEditingController = TextEditingController();
  final childAgeTextEditingController = TextEditingController();
  final allergiesTextEditingController = TextEditingController();
  final medicalConditionTextEditingController = TextEditingController();
  final anyThingTextEditingController = TextEditingController();

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
}
