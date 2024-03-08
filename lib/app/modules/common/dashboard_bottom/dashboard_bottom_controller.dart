import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/modules/common/calender/calender_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/notification/notification_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_view.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/customer_home_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';

import '../../../res/constants/string_contants.dart';
import '../../nanny/nanny_views/nanny_calender_view/nanny_calender_view.dart';
import '../../nanny/nanny_views/nanny_home/nanny_home_view.dart';

class DashboardBottomController extends GetxController {
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
    update();
  }

  /// CUSTOMER
  List bottomBarScreenListCustomer = [
    const CustomerHomeView(),
    const RecentChatView(),
    const NotificationView(),
    const CalenderView(),
    const SettingView(),
  ];

  /// NANNY
  List bottomBarScreenListNanny = [
    const NannyHomeView(),
    const RecentChatView(),
    const NotificationView(),
    const NannyCalenderView(),
    const SettingView(),
  ];
}
