import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/socket/singnal_r_socket.dart';

class RecentChatController extends GetxController {
  final signalRHelper = SignalRHelper();
  redirectToChatScreen() {
    Get.to(const ChatView());
  }

  getRecetChatList() {
    signalRHelper.hubConnection.invoke('ChatList').then((value) {
      print("chat list invoked value:==>> $value");
    });
  }

  @override
  void onInit() {
    super.onInit();
    getRecetChatList();
  }
}
