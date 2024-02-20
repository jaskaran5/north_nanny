import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
  }
}
