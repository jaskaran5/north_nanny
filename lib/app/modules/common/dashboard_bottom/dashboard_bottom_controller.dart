import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/calender/calender_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/notification/notification_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';

import '../../customer/home/home_view.dart';

class DashboardBottomController extends GetxController {
  RxBool isFromPassword = false.obs;

  var bottomTabList = BottomTabs.values;

  RxInt selectedTabIndex = 0.obs;

  set selectedBottomTab(int value) {
    selectedTabIndex.value = value;
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
    update();
  }

  List bottomBarScreenList = [
    const HomeView(),
    const RecentChatView(),
    const NotificationView(),
    const CalenderView(),
    const SettingView(),
  ];
}
