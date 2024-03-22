import 'dart:developer';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/chat_list_response_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/socket/singnal_r_socket.dart';

class RecentChatController extends GetxController {
  String tag = "Socket";

  RxBool isShimmerEnabled = true.obs;
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

  redirectToChatScreen({required String id}) {
    Get.to(const ChatView(), arguments: id);
  }

  Future<void> invokedRecentChat() async {
    log("$tag chat list argumaents are:-->> invokedRecentChat");
    // _socketHelper.hubConnection.off("MyChatList");
    _socketHelper.hubConnection.on("MyChatList", (arguments) {
      var data = arguments?[0] as Map<String, dynamic>;

      var res = ChatListResponseModel.fromJson(data);

      recetChatList = res.data?.chatList ?? [];
      log("$tag chat list argumaents are:-->> ${arguments?[0]}");
      log("$tag recetChatList:-->> $recetChatList");
      isShimmerEnabled.value = false;
      update();
    });

    var res = await _socketHelper.hubConnection.invoke('ChatList', args: []);

    log("$tag ChatList : $res");
    update();
  }

  getChatList() {}
}
