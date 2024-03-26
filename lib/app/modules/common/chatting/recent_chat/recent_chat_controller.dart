import 'dart:developer';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/chat_list_response_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/socket/singnal_r_socket.dart';

class RecentChatController extends GetxController {
  final String _logTag = "Socket";
  RxBool isShimmerEnabled = true.obs;

  // Assuming SignalRHelper is adjusted to manage hubConnection initialization.
  final SignalRHelper _socketHelper = SignalRHelper();

  List<ChatList> recentChatList = [];

  @override
  void onInit() {
    super.onInit();
    _initializeSignalRConnection();
  }

  void redirectToChatScreen({required String id}) {
    Get.to(const ChatView(), arguments: id);
  }

  Future<void> _initializeSignalRConnection() async {
    if (!_socketHelper.isConnected) {
      _socketHelper.reconnect();
    }
    _setupSignalRListeners();
    invokeRecentChat();
  }

  void _setupSignalRListeners() {
    _socketHelper.hubConnection.on("MyChatList", (arguments) {
      try {
        log("argument recent chat:-->>$arguments");
        var data = arguments?[0] as Map<String, dynamic>;
        var response = ChatListResponseModel.fromJson(data);
        recentChatList = response.data?.chatList ?? [];
        isShimmerEnabled.value = false;
        update();
      } catch (e) {
        log('$_logTag: Error processing chat list: $e');
      }
    });
  }

  Future<void> invokeRecentChat() async {
    try {
      var response =
          await _socketHelper.hubConnection.invoke('ChatList', args: []);
      log('$_logTag ChatList Response: $response');
    } catch (e) {
      log('$_logTag: Error invoking ChatList: $e');
    }
  }
}
