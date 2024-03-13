import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/availability_by_day_model.dart';
import 'package:northshore_nanny_flutter/app/models/availability_list_model.dart';
import 'package:northshore_nanny_flutter/app/models/child_list_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/get_nanny_details_reponse_model.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_binding.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/schedule_nanny/schedule_nanny_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';

class GetNannyProfileController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  RxInt nannyId = 0.obs;

  RxBool isDataLoading = true.obs;

  /// used to store data from backend
  var profileData = MyProfileModel();

  int selectedIndex = 0;

  RxBool isContained = false.obs;

  GetNannyData? getNannyData;

  AvailabilityByDayModel? singleDay;

  RxList<ChildData> childList = <ChildData>[].obs;
  RxList<String> selectedServices = <String>[].obs;

  List<String>? priceList = [
    '\$10',
    '\$10',
    '\$10',
    '\$10',
    '\$10',
    '',
  ];

  updateIsContained({required bool val}) {
    isContained.value = val;
    update();
  }

  //Update selected services
  updateSelectedServices({value}) {
    if (selectedServices.contains(value)) {
      selectedServices.remove(value);
    } else {
      selectedServices.add(value);
    }
    update();

    log("selected services are:-->> $selectedServices");
  }

  /// used to check element have event or not
  bool isElementEqualToData(List<AvilabilityList> list, int day, int month) {
    for (var value in list) {
      if (value.openingTime?.day == day && value.openingTime?.month == month) {
        return true;
      }
    }
    return false;
  }

  bool isFavorite = false;

  List<String> profileTabList = [
    TranslationKeys.about.tr,
    TranslationKeys.services.tr,
    TranslationKeys.availability.tr
  ];

  /// used to set the referral
  bool? isReferral = false;

  /// check selected date

  bool isOpeningTimeContained(
      DateTime dateToCheck, List<AvilabilityList> availabilityList) {
    bool isContained = false;
    for (var selectedData in availabilityList) {
      // Compare the dates
      if ((DateTime(dateToCheck.day, dateToCheck.month, dateToCheck.year))
          .isAtSameMomentAs((DateTime(
              selectedData.openingTime!.day,
              selectedData.openingTime!.month,
              selectedData.openingTime!.year)))) {
        print("contain--> $dateToCheck,${selectedData.openingTime!}");
        isContained = true;
        break;
      } else {
        isContained = false;
        print("not contain--> $dateToCheck,${selectedData.openingTime!}");
      }
    }
    return isContained;
  }

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
  DateTime focusedDay = DateTime.now();

  updateSelectedDate({required DateTime date, required DateTime focusDate}) {
    selectedDate = date;
    focusedDay = focusDate;
    update();
  }

  /// start range day.
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  /// used to store availability list
  AvailabilityListModel? availabilityListModel;

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

  /// post api for get availabilities list
  getAvailableDataByDate() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        'utcDateTime': DateTime.now().toUtc().toIso8601String().toString(),
      };
      _apiHelper
          .postApi(
        ApiUrls.userBookingDeatil,
        body,
      )
          .futureValue((value) {
        printInfo(info: "Get Data from date $value");
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

  /// used to store range start date  .
  DateTime? rangeStartDate = DateTime.now();

  /// used to store range End date  .
  DateTime? rangeEndDate;

  /// used to check element have event or not
  // bool isElementEqualToData(List<AvailabilityListModelData> list, int day) {
  //   for (var value in list) {
  //     if (value.openingTime?.day == day) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  /// used to on the range selection
  bool isRangeSelection = false;

  /// GET NANNY DETAILS

  getNannyDetails() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        "id": nannyId.value,
        "dateTime": (DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'")
                .format((DateTime.now()).toUtc()))
            .toString()
      };

      log("get nanny profile body:------ $body");

      _apiHelper.postApi(ApiUrls.nannyDetails, body).futureValue((value) {
        printInfo(info: "post availability nanny  response value $value");
        var response = GetNannyDetailsResponseModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          // toast(msg: response.message.toString(), isError: false);
          isDataLoading.value = false;

          getNannyData = response.data!;
          update();
        } else {
          isDataLoading.value = false;

          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      isDataLoading.value = false;

      printError(info: "post availability  Nanny  API ISSUE $s");
    }
  }

  @override
  void onInit() {
    nannyId.value = Get.arguments ?? 0;
    update();

    log("nanny id in nanny profile :-->> ${nannyId.value}");
    super.onInit();
  }

  @override
  void onReady() {
    getNannyDetails();
    super.onReady();
  }

  /// REDIRECT TO NANNY SCHEDULE VIEW

  redirectToNannyScheduleView() async {
    Get.to(() => const ScheduleNannyView());
    await getChildListApi();
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
          childList.value = res.data ?? [];

          if (res.data!.isEmpty) {
            // toast(msg: "Child List Empty", isError: false);
          }

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

  getDataByDate() {}

  /// --------->>>>>> --------------------->>>>>>>>>>>CONFIRM BOOKING

  confirmBookingApi() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      _apiHelper
          .getPosts(
        ApiUrls.bookAppointment,
      )
          .futureValue((value) {
        printInfo(info: "CHILD LIST $value");
        // var res = ChildListResponseModel.fromJson(value);

        // log("res--${res.response}");

        // if (res.response == AppConstants.apiResponseSuccess) {
        //   childList.clear();
        //   log("child list length:-${res.data?.length}");
        //   log("child list data:-${res.data}");
        //   childList.value = res.data ?? [];

        //   if (res.data!.isEmpty) {
        //     // toast(msg: "Child List Empty", isError: false);-*
        //   }

        //   update();

        //   log("child list data is :-->> ${childList.value.toString()}");
        // } else {
        //   toast(msg: res.message!, isError: true);
        // }
      }, retryFunction: getChildListApi);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "add child post  API ISSUE $s");
    }
  }
}
