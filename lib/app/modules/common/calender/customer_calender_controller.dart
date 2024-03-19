import 'dart:developer';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/user_booking_details_by_date.dart';
import 'package:northshore_nanny_flutter/app/models/user_booking_details_reponse_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import '../../../data/api/api_helper.dart';

class CustomerCalenderController extends GetxController {
  DateTime?selectedDay ;
  DateTime focusDay = DateTime.now();
  final ApiHelper _apiHelper = ApiHelper.to;
//
  /// used to store availability list
  UserBookingDetailsResponseModel? userBookingDetail;
  UserBookingDataByDate? singleDateBookingData;

  getCustomerAllBookingDetailsApi({required DateTime date}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {"utcDateTime": date.toUtc().toIso8601String()};

      log("body is ->> ${body.entries}");

      _apiHelper.postApi(ApiUrls.getAllNannyBookingDates, body).futureValue(
        (value) {
          printInfo(info: "get customer booking list  api:-->> $value");

          var res = UserBookingDetailsResponseModel.fromJson(value);

          if (res.response == AppConstants.apiResponseSuccess) {
            log("user booking details =---->>SUCCESS");

            userBookingDetail = res;
          }
          update();
        },
        retryFunction: () {},
      );
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "GET ALL BOOKING DETAILS API $s");
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCustomerAllBookingDetailsApi(date: DateTime.now());
    getSelectedDateBookingDetail(selectedDate: DateTime.now());
  }

  /// this  method used to check the which days have events
  isEvent(
      {required List<DateTime> daysList,
      required int day,
      required int month}) {
    for (var value in daysList) {
      if (value.day == day && value.month == month) {
        return true;
      }
    }
    return false;
  }

  /// get CUSTOMER selected  date booking detail.
  getSelectedDateBookingDetail({required DateTime selectedDate}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "dateTime": selectedDate.toUtc().toIso8601String(),
      };
      _apiHelper.postApi(ApiUrls.userBookingDataByDate, body).futureValue(
          (value) {
        printInfo(info: "get  cUSTOMER booking single date   $value");
        var response = UserBookingDetailsByDateResponseModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          singleDateBookingData = response.data;
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "CUSTOMER booking detail single Get  API ISSUE $s");
    }
  }
}
