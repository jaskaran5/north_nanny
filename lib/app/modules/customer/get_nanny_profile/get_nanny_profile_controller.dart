import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
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

import '../../../models/get_nanny_booking_detail_in_customer.dart';

class GetNannyProfileController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;

  RxInt nannyId = 0.obs;

  RxBool isDataLoading = true.obs;

  /// used to store data from backend
  var profileData = MyProfileModel();

  int selectedIndex = 0;

  GetNannyData? getNannyData;

  NannyDataByBookingSlots? singleDay;

  RxList<ChildData> childList = <ChildData>[].obs;
  RxList<String> selectedServices = <String>[].obs;
  RxList<String> selectedChildList = <String>[].obs;

  /// used to store child ids
  RxList<int> selectedChildIds = <int>[].obs;

  List<String>? priceList = [
    '\$10',
    '\$10',
    '\$10',
    '\$10',
    '\$10',
    '',
  ];

  RxList receiptList = [].obs;

  updateReceiptList(value) {
    receiptList.add(value);
    update();
  }

  //Update selected services
  updateSelectedServices({required List<dynamic> value}) {
    selectedServices.clear();
    for (var element in value) {
      selectedServices.add(element.toString());
    }
    update();
    log("selected services are:-->> $selectedServices");
  }

  //Update selected CHILDREN
  updateSelectedChildren({required List<dynamic> value}) {
    selectedChildList.clear();
    selectedChildIds.clear();
    for (var element in value) {
      selectedChildList.add(element.toString());
      for (var value in childList) {
        if (value.name == element) {
          selectedChildIds.add(value.childId ?? 0);
        }
      }
    }
    log('child Ids List: $selectedChildIds');
    update();
    log("selected Children  are:-->> $selectedChildList");
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

  /// used to store range start date  .
  DateTime? rangeStartDate = DateTime.now();

  /// used to store range End date  .
  DateTime? rangeEndDate;

  /// used to on the range selection
  bool isRangeSelection = false;

  /// GET NANNY DETAILS
  getNannyDetails({required DateTime time}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        "id": nannyId.value,
        "dateTime": time.toUtc().toIso8601String(),
      };

      log("get nanny profile body:------ $body");

      _apiHelper.postApi(ApiUrls.nannyDetails, body).futureValue((value) {
        printInfo(info: "post availability nanny  response value $value");
        var response = GetNannyDetailsResponseModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
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
    getNannyDetails(time: DateTime.now());
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

  /// used to get single day data
  getNannyDataByDate({required DateTime date}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "nannyUserId": nannyId.value,
        "utcDateTime": date.toUtc().toIso8601String(),
      };

      _apiHelper
          .postApi(ApiUrls.nannyBookingDataByDate, jsonEncode(body))
          .futureValue((value) {
        var res = NannyDataByBookingSlots.fromJson(value);
        if (res.response == AppConstants.apiResponseSuccess) {
          singleDay = res;
          update();
        } else {
          toast(msg: res.message.toString(), isError: true);
        }
      }, retryFunction: getChildListApi);
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "get nanny details by date $s");
    }
  }

  /// --------->>>>>> --------------------->>>>>>>>>>>CONFIRM BOOKING --- >. ADD APPONUMENT <<<<----

  confirmBookingApi({
    required bool isUseReferral,
    required int nannyUserId,
    required int totalMinutes,
    required double totalPrice,
    required List<int> childIds,
    required DateTime openingTime,
    required DateTime closingTime,
  }) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        "isUseReferral": isUseReferral,
        "nannyUserId": nannyUserId,
        "currentUtcTime": DateTime.now().toUtc().toIso8601String(),
        "utcOpeningTime": openingTime.toUtc().toIso8601String(),
        "utcClosingTime": closingTime.toUtc().toIso8601String(),
        "services": selectedServices,
        "childId": childIds,
        "totalHour": totalMinutes,
        "totalBillAmount": isUseReferral ? totalPrice - 5 : totalPrice,
      };
      log('confirm Api body:$body');
      _apiHelper
          .postApi(
        ApiUrls.bookAppointment,
        jsonEncode(body),
      )
          .futureValue((value) {
        printInfo(info: "confirm booking $value");
        var res = ChildListResponseModel.fromJson(value);

        log("res--${res.response}");

        if (res.response == AppConstants.apiResponseSuccess) {
          toast(msg: res.message.toString(), isError: false);
          Get.back();
          update();
        } else {
          toast(msg: res.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "confirm Booking  API ISSUE $s");
    }
  }

  /// used to store total price;
  var totalPrice = 0.0.obs;

  /// used to get total price according  to services fees
  returnTotalPrice({
    required int servicesListLength,
    required double totalMinutesPrice,
    required bool isIncludeServicesFee,
  }) {
    var value = servicesListLength * 10 + totalMinutesPrice;
    if (isIncludeServicesFee) {
      /// 0.03 is deduction strip.
      var serviceFee = (value * 0.03);
      var total = value + serviceFee;
      totalPrice.value = total;
      return total;
    } else {
      totalPrice.value = value;
      return value;
    }
  }

  /// method used to get the service fee total of 3% {total*0.03}
  returnServiceFeeAccordingToTotalPrice(
      {required int servicesListLength, required double totalMinutesPrice}) {
    var value = servicesListLength * 10 + totalMinutesPrice;
    var servicesFee = (value * 0.03);

    /// 0.03 is deduction strip.
    return servicesFee;
  }

  ///used to get final date
  returnFinalTimeAccordingToDate(
      {required TimeOfDay? startTime, required DateTime day}) {
    if (startTime != null) {
      return DateTime(
        day.year,
        day.month,
        day.day,
        startTime.hour,
        startTime.minute,
      );
    } else {
      return DateTime.now();
    }
  }
}
