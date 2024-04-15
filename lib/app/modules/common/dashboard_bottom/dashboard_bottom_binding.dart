import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/dashboard_bottom/dashboard_bottom_controller.dart';

import '../chatting/recent_chat/recent_chat_controller.dart';

class DashboardBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardBottomController>(
      () => DashboardBottomController(),
    );
    Get.lazyPut<RecentChatController>(
      () => RecentChatController(),
    );
  }
}
