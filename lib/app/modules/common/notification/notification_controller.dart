import 'dart:convert';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/get_notification_list_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';

import '../../../data/api/api_helper.dart';
import '../../../res/constants/api_urls.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/custom_toast.dart';
import '../dashboard_bottom/dashboard_bottom_controller.dart';

class NotificationController extends GetxController {
  /// api wrapper object.
  final ApiHelper _apiHelper = ApiHelper.to;

  /// this instance used to store the list of notifications.
  NotificationListModel? notificationListModel;

  /// used to hide the notification no data found variable.
  RxBool isNotificationLoading = true.obs;

  /// used to get notification list
  getNotificationList() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      _apiHelper
          .postApi(
        ApiUrls.notificationList,
        null,
      )
          .futureValue((value) {
        printInfo(info: "Get Notification List  response value $value");
        var response = NotificationListModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          notificationListModel = response;
          isNotificationLoading.value = false;
          update();
        } else {
          isNotificationLoading.value = false;
          toast(msg: response.message, isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      isNotificationLoading.value = false;
      printError(info: "Get Notification List   API ISSUE $s");
    }
  }

  /// used to read the  notification list.
  Future<void> postNotificationRead({required int notificationId}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {"notificationId": notificationId};
      _apiHelper
          .postApi(
        ApiUrls.readNotification,
        jsonEncode(body),
      )
          .futureValue((value) {
        printInfo(info: "post read Notification response value $value");
        /// used to get notification counts.
        Get.find<DashboardBottomController>().getNotificationCount();
        /// used to get notification list .
        getNotificationList();
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "post read Notification API ISSUE $s");
    }
  }

  @override
  void onInit() {
    super.onInit();
    getNotificationList();
  }
}
