import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/child_reponse_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class CreateChildProfileController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;
  final noOfChildrenTextEditingController = TextEditingController(text: "1");
  final childNameTextEditingController = TextEditingController();
  final childAgeTextEditingController = TextEditingController();
  final allergiesTextEditingController = TextEditingController();
  final medicalConditionTextEditingController = TextEditingController();
  final anyThingTextEditingController = TextEditingController();
  RxDouble linearIndicatorDividedValue = 0.0.obs;
  RxInt currentIndex = 1.obs;

  RxInt noOfChild = 1.obs;
  RxDouble linearIndicatorValue = 0.0.obs;
  RxDouble dividedLinearIndicatorValue = 0.0.obs;

  /// gender list.
  List<String> genderList = GenderConstant.values
      .map((e) => e.genderName.capitalizeFirst.toString())
      .toList();

  updateController() {
    currentIndex++;
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

  /// selected Gender
  String? selectedGender = '';

  /// storeGenderValue
  void setGenderValue(String gender) {
    selectedGender = gender;
    update();
  }

  /// UPDATE NO OF CHILDREN
  updateNoOfChildren({val}) {
    noOfChild.value = val;

    updateLinearIndicator().then((value) {
      dividedLinearIndicatorValue.value = linearIndicatorValue.value;

      log("divided: ${dividedLinearIndicatorValue.value}");
      log("linear: ${linearIndicatorValue.value}");
    });
    update();

    RouteManagement.goToAddChildProfileView();

    log("divide value :-->> ${dividedLinearIndicatorValue.value}");
  }

  /// * -------------->>>>>>>..          ADD CHILD VALIDATION <<<<<<<<<<<<<<<< =========
  ///
  addChildValidation(context) {
    if (childNameTextEditingController.text.isEmpty) {
      toast(
        msg: "Please Enter Child Name",
        isError: true,
      );
    } else {
      addChildApi(context);
    }
  }

  /// * -------------->>>>>>>..          ADD CHILD API <<<<<<<<<<<<<<<< =========
  addChildApi(context) async {
    // Show CircularProgressIndicator while processing
    // showDialog(
    //   context: context,
    //   barrierDismissible: false, // Prevent user from dismissing dialog
    //   builder: (BuildContext context) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );

    var listOfData = [
      {
        "name": childNameTextEditingController.text.trim(),
        "age": childAgeTextEditingController.text.trim(),
        if (selectedGender!.isNotEmpty)
          "gender": selectedGender == "Male" ? 1 : 2,
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
        clearTextFields();
        if (currentIndex < noOfChild.value) {
          updateController();
          log(currentIndex.toString());

          updateLinearIndicatorValueWhenDataFilled();

          // Get.back();
        } else {
          Get.back();
          RouteManagement.goToOffAllDashboard(isFromSetting: false);
        }
      }

      // Get.back();
      printInfo(info: "add child response model: ==>> $value");
    }, retryFunction: () {});
  }

  //clear text fields
  clearTextFields() {
    childNameTextEditingController.clear();
    childAgeTextEditingController.clear();
    selectedGender = '';
    allergiesTextEditingController.clear();
    medicalConditionTextEditingController.clear();
    anyThingTextEditingController.clear();
    update();
  }

  /// ------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>  SKIP FOR NOW <<<<<<<<< ------------
  skipChildApi() {
    var listOfData = [];

    _apiHelper.postApi(ApiUrls.addChild, listOfData).futureValue((value) {
      RouteManagement.goToOffAllDashboard(isFromSetting: false);
    }, retryFunction: () {});
  }
}
