import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/modules/common/calender/customer_calender_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/notification/notification_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_view.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/customer_home_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';

import '../../../data/api/api_helper.dart';
import '../../../models/notification_count_model.dart';
import '../../../res/constants/api_urls.dart';
import '../../../res/constants/app_constants.dart';
import '../../../res/constants/string_contants.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/custom_toast.dart';
import '../../nanny/nanny_views/nanny_calender_view/nanny_calender_view.dart';
import '../../nanny/nanny_views/nanny_home/nanny_home_view.dart';

class DashboardBottomController extends GetxController {
  /// api wrapper object.
  final ApiHelper _apiHelper = ApiHelper.to;
  RxBool isFromPassword = false.obs;

  var bottomTabList = BottomTabs.values;

  RxInt selectedTabIndex = 0.obs;

  set selectedBottomTab(int value) {
    selectedTabIndex.value = value;
    update();
  }

  String loginType = '';

  checkLoginType() {
    loginType = Storage.getValue(StringConstants.loginType);
    update();
  }

  @override
  void onInit() {
    super.onInit();

    isFromPassword.value = Get.arguments;

    if (isFromPassword.value) {
      selectedTabIndex.value = 4;
    } else {
      selectedTabIndex.value = 0;
    }
    checkLoginType();
    getNotificationCount();
    update();
  }

  /// CUSTOMER
  List bottomBarScreenListCustomer = [
    const CustomerHomeView(),
    RecentChatView(),
    const NotificationView(),
    const CustomerCalenderView(),
    const SettingView(),
  ];

  /// NANNY
  List bottomBarScreenListNanny = [
    const NannyHomeView(),
    RecentChatView(),
    const NotificationView(),
    const NannyCalenderView(),
    const SettingView(),
  ];

  /// used to store the data of notification count
  NotificationCountModel? notificationCountModel;

  /// used to get notification Count
  getNotificationCount() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      _apiHelper
          .postApi(
        ApiUrls.getNotificationCount,
        null,
      )
          .futureValue((value) {
        printInfo(info: "Get Notification response value $value");
        var response = NotificationCountModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          notificationCountModel = response;
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Get Notification response API ISSUE $s");
    }
  }
}
