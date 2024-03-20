import 'dart:developer';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/chat_list_response_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/socket/singnal_r_socket.dart';
import 'package:signalr_netcore/signalr_client.dart';

class RecentChatController extends GetxController {
  String tag = "Socket";
  //
  final _socketHelper = SignalRHelper();
  // late HubConnection _hubConnection;

  List<ChatList> recetChatList = [];

  @override
  onInit() {
    if (_socketHelper.isConnected == false) {
      _socketHelper.reconnect();
    }
    _socketHelper.hubConnection = _socketHelper.getHubConnection();
    super.onInit();
    invokedRecentChat();

    //   getRecetChatList();
  }

  redirectToChatScreen() {
    Get.to(const ChatView());
  }

  Future<void> invokedRecentChat() async {
    log("$tag chat list argumaents are:-->> invokedRecentChat");
    _socketHelper.hubConnection.off("MyChatList");
    _socketHelper.hubConnection.on("MyChatList", (arguments) {
      var data = arguments?[0] as Map<String, dynamic>;

      var res = ChatListResponseModel.fromJson(data);

      recetChatList = res.data?.chatList ?? [];
      log("$tag chat list argumaents are:-->> ${arguments?[0]}");
      log("$tag recetChatList:-->> $recetChatList");
      update();
    });

    var res = await _socketHelper.hubConnection.invoke('ChatList', args: []);
    log("$tag ChatList : $res");
  }

  getChatList() {}
}
