import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/chat_list_response_model.dart';

import 'package:northshore_nanny_flutter/app/models/filter_recent_chat_response_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/socket/singnal_r_socket.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/navigators/app_routes.dart';

import '../../../../../navigators/routes_management.dart';
import '../../../../data/storage/storage.dart';

class RecentChatController extends GetxController {
  final String _logTag = "Socket";
  final ApiHelper _apiHelper = ApiHelper.to;

  RxBool isShimmerEnabled = true.obs;
  final debounce = Debouncer(delay: const Duration(seconds: 1));

  final SignalRHelper socketHelper = SignalRHelper();

  TextEditingController recentChatTextEditingController =
      TextEditingController();
  // late HubConnection _hubConnection;

  // Assuming SignalRHelper is adjusted to manage hubConnection initialization.
  // final SignalRHelper _socketHelper = SignalRHelper();

  List<ChatList> recentChatList = [];

  RxBool isSearchable = false.obs;

  toggleSearch() {
    isSearchable.value = !isSearchable.value;
    update();
  }

  initMessages() {
    invokeRecentChat();
    if (Get.currentRoute == Routes.dashboard) {
      socketHelper.hubConnection.off("ReciveMessage");
      socketHelper.hubConnection.on(
        'ReciveMessage',
        (arguments) {
          debugPrint("ReciveMessage=========>>");
          1.delay(() {
            invokeRecentChat();
          });
        },
      );
    }
  }

  void redirectToChatScreen({required String id}) async {
    dynamic result = await Get.toNamed(Routes.chat, arguments: id);

    log("back result:-->> $result");

    if (result == 'true') {
      invokeRecentChat();
      invokeRecentChat();
    }
  }

  void invokeRecentChat() {
    Utils.hasNetwork();
    socketHelper.hubConnection.off("MyChatList");
    socketHelper.hubConnection.on("MyChatList", (arguments) {
      try {
        log("argument recent chat:-->>$arguments");
        var data = arguments?[0] as Map<String, dynamic>;
        var response = ChatListResponseModel.fromJson(data);
        if (response.response == 401) {
          log('>>>>>>>>>> MiddleWareHit >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          Storage.clearStorage();
          RouteManagement.goChooseBabySitter();
        } else {
          recentChatList = response.data?.chatList ?? [];
          isShimmerEnabled.value = false;
        }
        update();
      } catch (e) {
        log('$_logTag: Error processing chat list: $e');
      }
    });
    socketHelper.hubConnection.invoke('ChatList', args: [""]);
  }

  searchChat(String name) {
    debounce.call(() {
      // if (name.trim().isNotEmpty)
      // {
      searchChatUser(name: name);
      // }
    });
  }

  //** Search chat user */

  searchChatUser({required String name}) {
    log("name :-->> $name");
    var body = {"name": name.trim()};
    try {
      _apiHelper.postApi(ApiUrls.searchChatUser, body).futureValue((value) {
        log("search chat user:-->>{$value}");

        var res = FilterRecentChatResponseModel.fromJson(value);

        if (res.response.toString() ==
            AppConstants.apiResponseSuccess.toString()) {
          log("filter recent chat list length ---->>>>>> ${res.data!.chatList?.length}");
          recentChatList = res.data!.chatList ?? [];
          update();
        }
      }, retryFunction: () {});
    } catch (e, s) {
      // toast(msg: e.toString(), isError: true
      printError(info: "filter chat post  API ISSUE $s");
    }
  }
}
