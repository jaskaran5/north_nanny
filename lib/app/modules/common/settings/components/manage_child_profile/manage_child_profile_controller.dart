import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/child_list_response_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';
import 'package:northshore_nanny_flutter/navigators/app_routes.dart';

class ManageChildProfileController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;
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

  /// gender list.
  List<String> genderList = GenderConstant.values
      .map((e) => e.genderName.capitalizeFirst.toString())
      .toList();

  RxList<ChildData> childList = <ChildData>[].obs;

  /// open gender dropDown,
  bool? showGenderDropDown = false;

  /// selected Gender
  String? selectedGender = '';

  /// storeGenderValue
  void setGenderValue(String gender) {
    selectedGender = gender;
    update();
  }

  /// REDIRECT TO ADD CHILD SCREEN
  redirectToAddChildScreen() {
    Get.toNamed(Routes.addChildProfile);
  }

  /// REDIRECT TO EDIT CHILD SCREEN

  redirectToEditChildScreen() {
    Get.toNamed(Routes.editChildProfile);
  }

//** GET CHILD LIST API */
  getChildListApi() {
    _apiHelper
        .getPosts(
      ApiUrls.childList,
    )
        .futureValue((value) {
      printInfo(info: "CHILD LIST $value");
      var res = ChildListResponseModel.fromJson(value);

      log("res--${res.response}");

      if (res.response == AppConstants.apiResponseSuccess) {
        childList.clear();
        log("child list length:-${res.data?.length}");
        log("child list data:-${res.data}");

        toast(msg: res.message!, isError: false);
        childList.value = res.data ?? [];
        update();

        log("child list data is :-->> ${childList.value}");
      } else {
        toast(msg: res.message!, isError: true);
      }
    }, retryFunction: getChildListApi);
  }

  @override
  void onReady() {
    getChildListApi();
    super.onReady();
  }
}
