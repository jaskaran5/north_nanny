import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_controller.dart';

class RecentChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecentChatController>(
      () => RecentChatController(),
    );
  }
}
