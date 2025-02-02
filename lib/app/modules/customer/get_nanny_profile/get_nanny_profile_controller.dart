import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/child_list_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/get_nanny_details_reponse_model.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_favourite_response_model.dart';
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
import 'package:northshore_nanny_flutter/app/widgets/multi_selct_dialog.dart';
import 'package:northshore_nanny_flutter/app/widgets/multi_select_children.dart';
import 'package:northshore_nanny_flutter/navigators/app_routes.dart';

import '../../../../navigators/routes_management.dart';
import '../../../models/get_nanny_booking_detail_in_customer.dart';
import '../../../models/validator_response.dart';
import '../../../res/constants/assets.dart';
import '../../../res/theme/styles.dart';

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

  TextEditingController typeOfServiceTextController = TextEditingController();
  TextEditingController selectChildrenTextController = TextEditingController();

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

  toggleFavouriteAndUnFavouriteApi(
      {required int userId, required bool isFavourite}) {
    try {
      var body = {
        "toUserId": userId,
        "isFavorite": isFavourite,
      };

      _apiHelper.postApi(ApiUrls.addOrRemoveFavoriteNanny, body).futureValue(
          (value) {
        var res = NannyFavouriteResponseModel.fromJson(value);

        if (res.response.toString() ==
            AppConstants.apiResponseSuccess.toString()) {
          log("response success is favourite");

          getNannyDetails(time: DateTime.now());

          update();
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Get dashboard data post  API ISSUE $s");
    }
  }

  /// used to check element have event or not
  bool isElementEqualToData(List<AvailabilityList> list, int day, int month) {
    for (var value in list) {
      if (value.openingTime?.day == day && value.openingTime?.month == month) {
        return true;
      }
    }
    return false;
  }

  RxBool isFavorite = false.obs;

  updateIsFavourite() {
    isFavorite.value = !isFavorite.value;

    toggleFavouriteAndUnFavouriteApi(
        userId: nannyId.value, isFavourite: isFavorite.value);

    update();
  }

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
    startTime = null;
    endTime = null;
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
  bool isBookingMore = false;

  usedToStoreNannyID() {
    nannyId.value = Get.arguments ?? 0;
    update();
  }

  /// GET NANNY DETAILS
  getNannyDetails({required DateTime time, int? nannyUserID}) async {
    usedToStoreNannyID();
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        "id": nannyUserID ?? nannyId.value,
        "dateTime": time.toUtc().toIso8601String(),
      };

      log("get nanny profile body:------ $body");

      _apiHelper.postApi(ApiUrls.nannyDetails, body).futureValue((value) {
        printInfo(info: "get nanny profile  response value $value");
        var response = GetNannyDetailsResponseModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          isDataLoading.value = false;
          getNannyData = response.data!;
          isFavorite.value = response.data?.isFavorite ?? false;
          update();
        } else {
          isDataLoading.value = false;

          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      isDataLoading.value = false;

      printError(info: "get nanny profile API ISSUE $s");
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

          log("child list data is :-->> ${childList.toString()}");
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
  getNannyDataByDate({required DateTime date, int? nannyUserId}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "nannyUserId": nannyUserId ?? nannyId.value,
        "utcDateTime": date.toUtc().toIso8601String(),
      };
      log('get nanny Data by Date:$body');
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
    required String hourlyPrice,
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
        "hourlyPrice": double.parse(hourlyPrice),
        "totalBillAmount": totalPrice,
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
          // toast(msg: res.message.toString(), isError: false);
          /// used to show the booking details.
          RouteManagement.goToSuccessView(
            buttonText: TranslationKeys.backToHome.tr,
            successSvg: Assets.iconsSuccess,
            header: TranslationKeys.nannyRequested.tr,
            headerStyle: AppStyles.ubDarkBlackColor24W700,
            subHeader: TranslationKeys.notificationNannyAccept.tr,
            onTapButton: () {
              RouteManagement.goToOffAllDashboard(isFromSetting: false);
            },
            subTitleStyle: AppStyles.ubGrey16W500,
            subHeaderMaxLines: 2,
            headerMaxLines: 2,
            successImage: '',
            sendTipText: false,
          );
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

  /// confirm booking validator
  Future<bool> confirmBookingValidator({
    required List<String> servicesList,
    required List<int> childList,
    required String nannyUserId,
    required DateTime openingTime,
    required DateTime closingTime,
  }) async {
    bool value = await Validator.instance
        .confirmBookingValidator(childList: childList, services: servicesList);
    if (value == true) {
      var validate = await validateBookingAppointment(
          nannyUserId: nannyUserId,
          openingTime: openingTime,
          closingTime: closingTime);
      log('validator is >>>>>>>>>>> $validate');
      return validate;
      // return true;
    } else {
      toast(msg: Validator.instance.error, isError: true);
      return false;
    }
  }

  /// used to store total price;
  var totalPrice = 0.0.obs;

  /// used to get total price according  to services fees
  returnTotalPrice({
    required int servicesListLength,
    required String totalMinutesPrice,
    required bool isIncludeServicesFee,
  }) {
    var value = servicesListLength * 10 + double.parse(totalMinutesPrice);
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
      {required int servicesListLength, required String totalMinutesPrice}) {
    var value = servicesListLength * 10 + double.parse(totalMinutesPrice);
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

  /// REDIRECT TO ADD CHILD SCREEN
  redirectToAddChildScreen() async {
    bool check = await Get.toNamed(Routes.addChildProfile);

    if (check) {
      getChildListApi();
    }
  }

  /// used to show selected services list .
  void showMultiSelectDialogServices(BuildContext context) async {
    final List<String>? selectedOptions = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          title: "Select Services",
          options: getNannyData!.services!.toList(),
          selectedOptions: selectedServices, // initially selected options
        );
      },
    );

    if (selectedOptions != null) {
      selectedServices.value = selectedOptions;

      String items = selectedServices.join(', ');

      typeOfServiceTextController.text = items;
      update();
      // Do something with the selected options
      log('Selected Services List : $selectedOptions');
    }
  }

  /// used to show selected children list.
  void showMultiSelectDialogChildren(BuildContext context) async {
    final List<String>? selectedOptions = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialogChildren(
          onTapOnAddChild: () {
            Get.back();
            redirectToAddChildScreen();
          },
          title: "Select Children",
          options: childList.map((child) => child.name).toList(),
          selectedOptions: selectedChildList, // initially selected options
        );
      },
    );

    if (selectedOptions != null) {
      selectedChildList.value = selectedOptions;
      selectedChildIds.clear();
      for (var i = 0; i < selectedChildList.length; i++) {
        for (var element in childList) {
          if (element.name == selectedChildList[i].toString()) {
            selectedChildIds.add(element.childId ?? 0);
          }
        }
      }

      String items = selectedChildList.join(', ');

      selectChildrenTextController.text = items;
      log('child Ids List: $selectedChildIds');
      update();
      // Do something with the selected options
      log('Selected child list: $selectedOptions');
    }
  }

  /// used to validate the confirm booking .
  Future<bool> validateBookingAppointment({
    required String nannyUserId,
    required DateTime openingTime,
    required DateTime closingTime,
  }) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return false;
      }

      var body = {
        "nannyUserId": nannyUserId,
        "currentUtcTime": DateTime.now().toUtc().toIso8601String(),
        "utcOpeningTime": openingTime.toUtc().toIso8601String(),
        "utcClosingTime": closingTime.toUtc().toIso8601String(),
      };
      log('Validate booking appointment Api body:$body');
      var value = await _apiHelper.postApi(
        ApiUrls.validateAppointment,
        jsonEncode(body),
      );
      var response = ValidatorResponse.fromJson(value.body);

      if (response.response == AppConstants.apiResponseSuccess) {
        log('response>>>>>>>> true');
        return true;
      } else {
        log('response>>>>>>>> false');
        toast(msg: response.message.toString(),isError: true);
        return false;
      }
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "validate Booking  appointment API ISSUE $s");
      return false;
    }
  }
}
