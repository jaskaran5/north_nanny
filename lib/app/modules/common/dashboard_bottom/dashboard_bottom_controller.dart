import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/calender/calender_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/notification/notification_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_view.dart';
import 'package:northshore_nanny_flutter/app/res/constants/enums.dart';

import '../../customer/home/home_view.dart';

class DashboardBottomController extends GetxController {
  var bottomTabList = BottomTabs.values;

  int selectedTabIndex = 0;

  set selectedBottomTab(int value) {
    selectedTabIndex = value;
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
