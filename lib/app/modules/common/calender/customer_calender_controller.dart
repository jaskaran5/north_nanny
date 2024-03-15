import 'dart:developer';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/availability_list_model.dart';
import 'package:northshore_nanny_flutter/app/models/user_booking_details_reponse_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import '../../../data/api/api_helper.dart';

class CustomerCalenderController extends GetxController {
  DateTime selectedDay = DateTime.now();
  final ApiHelper _apiHelper = ApiHelper.to;

  /// used to store availability list
  List<UserBookingData> userBookingDataList = [];
  UserBookingData? userBookingData;

  getCustomerAllBookingDetailsApi() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {"dateTime": DateTime.now().toUtc().toIso8601String()};

      log("body is ->> ${body.entries}");

      _apiHelper.postApi(ApiUrls.userBookingDeatil, body).futureValue(
        (value) {
          printInfo(info: "get customer profile api:-->> $value");

          var res = UserBookingDetailsResponseModel.fromJson(value);

          if (res.response == AppConstants.apiResponseSuccess) {
            log("user booking details =---->>SUCCESS");

            userBookingDataList = res.data ?? [];
          }
          update();
        },
        retryFunction: () {
          getCustomerAllBookingDetailsApi();
        },
      );
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "GET ALL BOOKING DETAILS API $s");
    }
  }

  @override
  void onInit() {
    getCustomerAllBookingDetailsApi();
    super.onInit();
  }

  /// used to check element have event or not
  bool isElementEqualToData(List<UserBookingData> list, int day, int month) {
    for (var value in list) {
      if (value.openingTime?.day == day && value.openingTime?.month == month) {
        return true;
      }
    }
    return false;
  }
}
