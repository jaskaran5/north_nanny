import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_controller.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';

import '../../data/api/api_helper.dart';
import '../../res/constants/api_urls.dart';
import '../../res/constants/app_constants.dart';
import '../../utils/app_utils.dart';
import '../../utils/custom_toast.dart';
import '../../utils/translations/translation_keys.dart';

class NannyProfileController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  /// used to store data from backend
  var profileData = MyProfileModel();

  int selectedIndex = 0;

  List<DateTime> selectedDates = [];
  DateTime selectedDate = DateTime(DateTime.now().month);

  List<String>? priceList = [
    '\$ 10',
    '\$ 10',
    '\$ 10',
    '\$ 10',
    '\$ 10',
    '',
  ];
  bool isFavorite = false;

  List<String> profileTabList = [
    TranslationKeys.about.tr,
    TranslationKeys.services.tr,
    TranslationKeys.availability.tr
  ];

  /// used to set the referral
  bool? isReferral = false;

  /// get api for nanny profile model
  Future<void> getProfile() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      _apiHelper
          .getPosts(
        ApiUrls.getNannyProfile,
      )
          .futureValue((value) {
        printInfo(info: "Get Nanny profile response value $value");
        var response = MyProfileModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          profileData = response;

          selectedList.clear();
          if (!Get.isRegistered<SettingController>()) {
            SettingBinding().dependencies();
          } else {
            Get.find<SettingController>().nannyImage.value =
                response.data?.image ?? '';
            Get.find<SettingController>().nannyName.value =
                response.data?.name ?? '';
            Get.find<SettingController>().nannyEmail.value =
                response.data?.email ?? '';
            Get.find<SettingController>().update();
          }
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "post Bank details  Nanny  API ISSUE $s");
    }
  }

  /// start range day.
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  List<dynamic> selectedList = [];

  /// add nanny Availability validator
  addAvailabilityValidator(
      {required TimeOfDay? startTime,
      required TimeOfDay? endTime,
      required List<dynamic> availabilityList}) {
    var validate = Validator.instance
        .addNannyAvailabilityValidator(startTime: startTime, endTime: endTime);
    if (validate == true) {
      addAvailability(availabilityList: availabilityList);
    } else {
      toast(msg: Validator.instance.error, isError: true);
      update();
    }
  }

  /// add nanny availability
  addAvailability({required List<dynamic> availabilityList}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      if (availabilityList.isNotEmpty) {
        _apiHelper
            .postApi(
          ApiUrls.addAvailability,
          jsonEncode(availabilityList),
        )
            .futureValue((value) {
          printInfo(info: "post availability nanny  response value $value");
          var response = MyProfileModel.fromJson(value);
          if (response.response == AppConstants.apiResponseSuccess) {
            toast(msg: response.message.toString(), isError: false);
            update();
            Get.back();
          } else {
            toast(msg: response.message.toString(), isError: true);
          }
        }, retryFunction: () {});
      }
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "post availability  Nanny  API ISSUE $s");
    }
  }
}
