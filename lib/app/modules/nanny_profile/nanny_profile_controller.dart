import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';

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
  TimeOfDay? endTime;
  TimeOfDay? startTime;
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

  /// -------------------------khach ------------
  // DateRangePickerController datePickerController = DateRangePickerController();
  // final now = DateTime.now();
  //
  // bool isEqualToNow({required DateTime date}) {
  //   bool datesMatch =
  //       date.year == now.year && date.month == now.month && date.day == now.day;
  //   return datesMatch;
  // }
  //
  // bool isEqualToSelected({required DateTime date}) {
  //   bool datesMatch = date.year == selectedDate.year &&
  //       date.month == selectedDate.month &&
  //       date.day == selectedDate.day;
  //   return datesMatch;
  // }
  //
  // void onSelectedDateChange({required dynamic date}) {
  //   selectedDate = DateTime.parse(date.toString());
  //   log("selectedDate>>$selectedDate");
  //   update();
  // }
  //
  // void changeMonth({required bool increase}) {
  //   if (increase) {
  //     _increaseMonth();
  //   } else {
  //     _decreaseMonth();
  //   }
  //   update();
  // }
  //
  // void _increaseMonth() {
  //   final currentDisplayDate = datePickerController.displayDate;
  //   final nextMonth = DateTime((currentDisplayDate?.year ?? 0),
  //       (currentDisplayDate?.month ?? 0) + 1, (currentDisplayDate?.day ?? 0));
  //   datePickerController.displayDate = nextMonth;
  // }
  //
  // void _decreaseMonth() {
  //   final currentDisplayDate = datePickerController.displayDate;
  //   final previousMonth = DateTime((currentDisplayDate?.year ?? 0),
  //       (currentDisplayDate?.month ?? 1) - 1, (currentDisplayDate?.day ?? 0));
  //   datePickerController.displayDate = previousMonth;
  // }
  //
  // String getFormattedMonthName() {
  //   final currentDisplayDate = datePickerController.displayDate;
  //   final monthFormat = DateFormat('MMMM');
  //   return monthFormat.format(currentDisplayDate ?? selectedDate);
  // }
  //
  // String getFormattedYear() {
  //   final currentDisplayDate = datePickerController.displayDate;
  //   final monthFormat = DateFormat('yyyy');
  //   return monthFormat.format(currentDisplayDate ?? selectedDate);
  // }
}
