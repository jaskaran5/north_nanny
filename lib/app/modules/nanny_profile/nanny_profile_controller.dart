import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/availability_list_model.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';

import '../../data/api/api_helper.dart';
import '../../models/availability_by_day_model.dart';
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

  ///----------------------------------------------- Availability ------------------------------

  /// used to get value on basis of single selection.
  DateTime? selectedDate;

  /// used to store focus date
  DateTime focusDate = DateTime.now();

  /// start range day.
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  /// used to store availability list
  AvailabilityListModel? availabilityListModel;

  /// add nanny Availability validator
  addAvailabilityValidator(
      {required TimeOfDay? startTime,
      required TimeOfDay? endTime,
      required List<DateTime> availabilityDatesList}) {
    var validate = Validator.instance
        .addNannyAvailabilityValidator(startTime: startTime, endTime: endTime);
    if (validate == true) {
      var finalList = [];
      if (!isRangeSelection && selectedDate != null) {
        finalList.add({
          "openingTime": DateTime(selectedDate!.year, selectedDate!.month,
                  selectedDate!.day, startTime!.hour, startTime.minute)
              .toUtc()
              .toIso8601String(),
          "closingTime": DateTime(selectedDate!.year, selectedDate!.month,
                  selectedDate!.day, endTime!.hour, endTime.minute)
              .toUtc()
              .toIso8601String()
        });
      } else {
        log('dates list==================>:$availabilityDatesList');

        var startTimeList = Utility.addTimeToList(
            dates: availabilityDatesList, addTime: startTime);
        var endTimeList = Utility.addTimeToList(
            dates: availabilityDatesList, addTime: endTime);
        finalList.clear();
        for (int i = 0; i < startTimeList.length; i++) {
          finalList.add({
            "openingTime": DateTime(
                    startTimeList[i].year,
                    startTimeList[i].month,
                    startTimeList[i].day,
                    startTimeList[i].hour,
                    startTimeList[i].minute)
                .toUtc()
                .toIso8601String(),
            "closingTime": DateTime(
                    endTimeList[i].year,
                    endTimeList[i].month,
                    endTimeList[i].day,
                    endTimeList[i].hour,
                    endTimeList[i].minute)
                .toUtc()
                .toIso8601String()
          });
        }
      }
      log('final List ==================>:$finalList');
      log('final List Length =================>:${finalList.length}');
      addAvailability(availabilityList: finalList);
    } else {
      toast(msg: Validator.instance.error, isError: true);
      update();
    }
  }

  /// add nanny availability post api
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
            // selectedIndex = 1;
            getAvailabilityList(
                dateTime: DateTime.now().toUtc().toIso8601String().toString());
            selectedDate = null;
            update();
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

  /// post api for get availabilities list
  getAvailabilityList({required String dateTime}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        'utcDateTime': dateTime,
      };

      log('get availabilityList Body:$body');
      _apiHelper
          .postApi(
        ApiUrls.nannyBookingList,
        body,
      )
          .futureValue((value) {
        printInfo(info: "Get Nanny Availability List response  $value");
        var response = AvailabilityListModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          availabilityListModel = response;
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Get Nanny Availability List    API ISSUE $s");
    }
  }

  /// used to store single day data.
  AvailabilityByDayModel? singleDay;

  /// post api for get availabilities by date
  getAvailabilityByDate({required String dateTime}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        'utcDateTime': dateTime,
      };

      log('get availability by date Body:$body');
      _apiHelper
          .postApi(
        ApiUrls.getNannyAvailabilityByDate,
        body,
      )
          .futureValue((value) {
        var response = AvailabilityByDayModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          singleDay = response;
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Get Nanny Availability by day    API ISSUE $s");
    }
  }

  /// used to store range start date  .
  DateTime? rangeStartDate;

  /// used to store range End date  .
  DateTime? rangeEndDate;

  /// used to check element have event or not
  bool isElementEqualToData(
      List<AvailabilityListModelData> list, int day, int month) {
    for (var value in list) {
      if (value.openingTime?.day == day && value.openingTime?.month == month) {
        return true;
      }
    }
    return false;
  }

  /// used to on the range selection
  bool isRangeSelection = false;

  /// used to edit the availability
  editAvailabilityValidator(
      {required TimeOfDay? startTime,
      required TimeOfDay? endTime,
      required DateTime? day}) {
    var validate = Validator.instance
        .addNannyAvailabilityValidator(startTime: startTime, endTime: endTime);
    if (validate) {
      editAvailability(editAvailability: {
        "openingTime": DateTime(
          day!.year,
          day.month,
          day.day,
          startTime!.hour,
          startTime.minute,
        ).toUtc().toIso8601String(),
        "closingTime": DateTime(
          day.year,
          day.month,
          day.day,
          endTime!.hour,
          endTime.minute,
        ).toUtc().toIso8601String()
      });
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// post api for edit  nanny availability.
  editAvailability({required Map<String, String> editAvailability}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      log('edit availability Map :$editAvailability');
      _apiHelper
          .postApi(
        ApiUrls.editNannyAvailability,
        jsonEncode(editAvailability),
      )
          .futureValue((value) {
        printInfo(info: "edit availability nanny $value");
        var response = AvailabilityByDayModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          toast(msg: response.message.toString(), isError: false);
          selectedIndex = 1;
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Edit availability  Nanny Post API ISSUE $s");
    }
  }

  /// delete api for delete the availability.
  deleteAvailability({required DateTime dateTime}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {"utcDateTime": dateTime.toString()};

      log('Delete availability  body  :$body');
      _apiHelper
          .postApi(
        ApiUrls.deleteNannyAvailability,
        jsonEncode(body),
      )
          .futureValue((value) {
        printInfo(info: "delete availability nanny ======> $value");
        var response = AvailabilityListModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          selectedIndex = 1;
          toast(msg: response.message.toString(), isError: false);
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Delete availability  Nanny Post API ISSUE $s");
    }
  }
}
