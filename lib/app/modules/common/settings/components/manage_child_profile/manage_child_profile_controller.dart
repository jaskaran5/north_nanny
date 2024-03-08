import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/child_list_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/child_reponse_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
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

  RxInt selectedChildId = 0.obs;

  /// selected Gender
  RxString selectedGender = ''.obs;

  /// storeGenderValue
  void setGenderValue(String gender) {
    selectedGender.value = gender;
    update();
  }

  /// REDIRECT TO ADD CHILD SCREEN
  redirectToAddChildScreen() {
    clearTextFields().then((value) async {
      bool check = await Get.toNamed(Routes.addChildProfile);

      if (check) {
        getChildListApi();
      }
    });
  }

  //clear textfields
  Future<void> clearTextFields() async {
    childAgeTextEditingController.clear();
    childNameTextEditingController.clear();
    selectedGender.value = '';
    allergiesTextEditingController.clear();
    medicalConditionTextEditingController.clear();
    anyThingTextEditingController.clear();
    update();
  }

  // /// UPDATE SELECTED CHILD

  updateSelectedChild({required int id}) {
    selectedChildId.value = id;

    print("selected child is:-->> ${selectedChildId.value}");
    update();
  }

//** GET CHILD LIST API */
  getChildListApi() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

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

          log("child list data is :-->> ${childList.value.toString()}");
        } else {
          toast(msg: res.message!, isError: true);
        }
      }, retryFunction: getChildListApi);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "add child post  API ISSUE $s");
    }
  }

  @override
  void onReady() {
    getChildListApi();
    super.onReady();
  }

  /// UPDATE EDIT CHILD DATA

  Future<void> editChildProfileTextFields({required int index}) async {
    childNameTextEditingController.text = childList[index].name!;
    childAgeTextEditingController.text = childList[index].age ?? '';

    if (childList[index].gender != null) {
      selectedGender.value =
          childList[index].gender.toString() == "1" ? "Male" : "Female";
    }

    allergiesTextEditingController.text =
        childList[index].allergiesDietaryAndRestrictions ?? '';
    medicalConditionTextEditingController.text =
        childList[index].medicalCondition ?? '';
    anyThingTextEditingController.text = childList[index].aboutChild ?? '';
    update();
  }

  //REDIRECT TO EDIT OR DELETE CHILD
  redirectToEditAndDeleteChildScreen({required int index}) {
    editChildProfileTextFields(index: index).then((value) async {
      bool check = await Get.toNamed(Routes.editChildProfile);
      if (check) {
        getChildListApi();
      }
    });
  }

  /// DELETE CHILD
  deleteChild() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {"childId": selectedChildId.value};

      _apiHelper.postApi(ApiUrls.deleteChild, body).futureValue((value) {
        var res = ChildResponseModel.fromJson(value);
        if (res.response == AppConstants.apiResponseSuccess) {
          toast(msg: res.message.toString(), isError: false);
          Get.back(result: true);
        } else {
          toast(msg: res.message.toString(), isError: true);
        }
      }, retryFunction: deleteChild);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "delete child post  API ISSUE $s");
    }
  }

  /// EDIT CHILD DATA

  editAndUpdateChildApi() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        "name": childNameTextEditingController.text.trim(),
        "age": childAgeTextEditingController.text.trim(),
        if (selectedGender.value.isNotEmpty)
          "gender": selectedGender.value == "Male" ? 1 : 2,
        "allergiesDietaryAndRestrictions":
            allergiesTextEditingController.text.trim(),
        "medicalCondition": medicalConditionTextEditingController.text.trim(),
        "aboutChild": anyThingTextEditingController.text.trim(),
        "id": selectedChildId.value
      };

      _apiHelper.postApi(ApiUrls.editChild, body).futureValue((value) {
        var res = ChildResponseModel.fromJson(
            value); //same as delete and edit success response are same
        if (res.response == AppConstants.apiResponseSuccess) {
          toast(msg: res.message.toString(), isError: false);
          Get.back(result: true);
        } else {
          toast(msg: res.message.toString(), isError: true);
        }
      }, retryFunction: editAndUpdateChildApi);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "edit and update child post  API ISSUE $s");
    }
  }

  /// * -------------->>>>>>>..          ADD CHILD VALIDATION <<<<<<<<<<<<<<<< =========
  ///
  addChildValidation() {
    if (childNameTextEditingController.text.isEmpty) {
      toast(
        msg: "Please Enter Child Name",
        isError: true,
      );
    } else {
      addChildApi();
    }
  }

  /// ADD CHILD

  addChildApi() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var listOfData = [
        {
          "name": childNameTextEditingController.text.trim(),
          "age": childAgeTextEditingController.text.trim(),
          if (selectedGender.value.isNotEmpty)
            "gender": selectedGender.value == "Male" ? 1 : 2,
          "allergiesDietaryAndRestrictions":
              allergiesTextEditingController.text.trim(),
          "medicalCondition": medicalConditionTextEditingController.text.trim(),
          "aboutChild": anyThingTextEditingController.text.trim()
        }
      ];

      printInfo(info: "child data list:--> $listOfData");

      _apiHelper.postApi(ApiUrls.addChild, listOfData).futureValue((value) {
        var res = ChildResponseModel.fromJson(value);
        if (res.response == AppConstants.apiResponseSuccess) {
          toast(msg: res.message!);

          Get.back(result: true);
        } else {
          toast(msg: res.message!);
        }
      }, retryFunction: addChildApi);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "add child post  API ISSUE $s");
    }
  }
}
