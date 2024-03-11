import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_dashboard_model.dart';
import 'package:northshore_nanny_flutter/app/utils/extensions.dart';

import '../../../../data/api/api_helper.dart';
import '../../../../res/constants/api_urls.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/custom_toast.dart';

class NannyHomeController extends GetxController {
  /// api wrapper object.
  final ApiHelper _apiHelper = ApiHelper.to;

  /// used to switch on or off
  bool isSwitchOn = true;

  /// home list
  var homeList = [
    {
      'userName': 'Michael Johnson',
      'totalPrice': 112,
      'totalRating': 4.5,
      'totalReview': '(21 reviews)',
      'date': 'January 2024, Friday',
      'totalTiming': '01:00 PM to 05:00 PM',
      'day': '03',
    },
    {
      'userName': 'Michael Johnson',
      'totalPrice': 112,
      'totalRating': 4.5,
      'totalReview': '(21 reviews)',
      'date': 'January 2024, Friday',
      'totalTiming': '01:00 PM to 05:00 PM',
      'day': '03',
    },
  ];

  var servicesList = [
    'Distance: 3 miles',
    'Number of kids: 2',
  ];

  /// nanny home dashboard model object

  /// used to store data from backend
  var nannyHomeData = NannyDashboardModel();

  /// get nanny dashboard api.
  Future<void> getHomeData() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      _apiHelper
          .getPosts(
        ApiUrls.nannyDashboard,
      )
          .futureValue((value) {
        printInfo(info: "Get Nanny Home response value $value");
        var response = NannyDashboardModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          nannyHomeData = response;
          isSwitchOn = response.data?.isAvailable ?? false;
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Nanny Home get  API ISSUE $s");
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (nannyHomeData.data == null) {
      getHomeData();
    }
  }

  /// set availability
  setAvailability({required bool isAvailable}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {"isAvailable": isAvailable};
      debugPrint('body of set availability  $body');
      _apiHelper.postApi(ApiUrls.setAvailability, body).futureValue((value) {
        printInfo(info: "set Nanny is Available response value $value");
        var response = NannyDashboardModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          toast(msg: response.message.toString(), isError: false);
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "set Nanny is Available Post  API ISSUE $s");
    }
  }
}
