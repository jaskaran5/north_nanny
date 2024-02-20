import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_view.dart';

class RecentChatController extends GetxController {
  redirectToChatScreen() {
    Get.to(const ChatView());
  }
}
