import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_dashboard_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';

import '../../../../data/api/api_helper.dart';
import '../../../../res/constants/api_urls.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/custom_toast.dart';
import '../../../common/socket/singnal_r_socket.dart';

class NannyHomeController extends GetxController {
  /// api wrapper object.
  final ApiHelper _apiHelper = ApiHelper.to;

  /// used to switch on or off
  bool isSwitchOn = true;

  /// used to store data from backend
  var nannyHomeData = NannyDashboardModel();

  /// used to return the loading things.
  RxBool isBookingLoading = true.obs;

  /// get nanny dashboard api.
  Future<void> getHomeData() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "utcDateTime": DateTime.now().toUtc().toIso8601String(),
      };
      _apiHelper
          .postApi(
        ApiUrls.nannyDashboard,
        jsonEncode(body),
      )
          .futureValue((value) {
        printInfo(info: "Get Nanny Home response value $value");
        var response = NannyDashboardModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          nannyHomeData = response;
          isBookingLoading.value = false;
          isSwitchOn = response.data?.isAvailable ?? false;
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
          isBookingLoading.value = false;
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      isBookingLoading.value = false;
      update();
      printError(info: "Nanny Home get  API ISSUE $s");
    }
  }

  final SignalRHelper _socketHelper = SignalRHelper();

  @override
  void onInit() {
    super.onInit();
    if (nannyHomeData.data == null &&
        Storage.getValue(StringConstants.loginType) == StringConstants.nanny) {
      getHomeData();
    }
    if (!_socketHelper.isConnected) {
      _socketHelper.init();
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
