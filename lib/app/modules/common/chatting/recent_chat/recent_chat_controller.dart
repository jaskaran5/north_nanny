import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/chat_list_response_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/socket/singnal_r_socket.dart';
import 'package:northshore_nanny_flutter/navigators/app_routes.dart';

class RecentChatController extends GetxController {
  final String _logTag = "Socket";
  RxBool isShimmerEnabled = true.obs;


  final SignalRHelper _socketHelper = SignalRHelper();
  // late HubConnection _hubConnection;

  // Assuming SignalRHelper is adjusted to manage hubConnection initialization.
  // final SignalRHelper _socketHelper = SignalRHelper();

  List<ChatList> recentChatList = [];

  @override
  void onInit() {
    super.onInit();
    if(!_socketHelper.isConnected){
      _socketHelper.init();
    }
    _initializeSignalRConnection();

  }

  initMessages(){
    if(Get.currentRoute == Routes.dashboard){
      _socketHelper.hubConnection.off("ReciveMessage");
      _socketHelper.hubConnection.on('ReciveMessage', (arguments) {
        print("ReciveMessage=========>>");
        1.delay((){
          invokeRecentChat();
        });
        },
      );
    }

  }

  void redirectToChatScreen({required String id}) async {
    dynamic result = await Get.to(()=>const ChatView(), arguments: id);

    log("back result:-->> $result");

    if (result == 'true') {
      invokeRecentChat();
      invokeRecentChat();
    }
  }

  Future<void> _initializeSignalRConnection() async {
    if (!_socketHelper.isConnected) {
      _socketHelper.reconnect();
    }
    invokeRecentChat();
    invokeRecentChat();
  }

  void invokeRecentChat() {
    _socketHelper.hubConnection.off("MyChatList");
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
    _socketHelper.hubConnection.invoke('ChatList', args: []);
  }


}
