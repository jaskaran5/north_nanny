import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_booking_details.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';

import '../../../../data/api/api_helper.dart';
import '../../../../models/nanny_booking_detail.dart';
import '../../../../res/constants/api_urls.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/custom_toast.dart';

class NannyCalenderController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;
  DateTime? selectedDay;
  DateTime focusDate = DateTime.now();

  /// for all details
  NannyBookingDetails? nannyBookingDetails;

  /// for single date
  NannyBookingDetail? nannyBookingDetail;

  /// get nanny all booking details.
  getAllBookings({required DateTime time}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "utcDateTime": time.toUtc().toIso8601String(),
      };
      _apiHelper
          .postApi(
        ApiUrls.getNannyAllBookingDates,
        jsonEncode(body),
      )
          .futureValue((value) {
        printInfo(
            info:
                "Get all  Nanny booking dates in calender response value $value");
        var response = NannyBookingDetails.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          nannyBookingDetails = response;
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Nanny booking details Get  API ISSUE $s");
    }
  }

  /// get nanny selected  booking detail.
  getSelectedDateBookingDetail({required DateTime selectedDate}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "dateTime": selectedDate.toUtc().toIso8601String(),
      };
      _apiHelper
          .postApi(
        ApiUrls.postNannyBookingDetails,
        jsonEncode(body),
      )
          .futureValue((value) {
        printInfo(info: "get  Nanny booking single date   $value");
        var response = NannyBookingDetail.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          nannyBookingDetail = response;
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Nanny booking detail single Get  API ISSUE $s");
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllBookings(time: DateTime.now());
    getSelectedDateBookingDetail(selectedDate: DateTime.now());
  }

  /// this  method used to check the which days have events
  isEvent(
      {required List<DateTime> daysList,
      required int day,
      required int month}) {
    for (var value in daysList) {
      if (value.day == day && value.month == month) {
        debugPrint('true');
        return true;
      }
    }
    return false;
  }

  /// post api for checking th
}
