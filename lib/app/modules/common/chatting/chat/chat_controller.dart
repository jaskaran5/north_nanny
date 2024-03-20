import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/get_nanny_details_reponse_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/socket/singnal_r_socket.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';

class ChatController extends GetxController {
  TextEditingController chatTextController = TextEditingController();
  final ApiHelper _apiHelper = ApiHelper.to;
  final _socketHelper = SignalRHelper();

  RxList messageList = <RxList>[].obs;

  RxString otherUserId = ''.obs;
  RxBool isOnline = false.obs;

  GetNannyData? getNannyData;

  RxList chatMessageList = [
    {"senderType": "parents", "msg": "hello"},
    {"senderType": "nanny", "msg": "sdf"},
    {"senderType": "parents", "msg": "165"},
    {"senderType": "nanny", "msg": "re"},
    {"senderType": "parents", "msg": "423"},
    {"senderType": "parents", "msg": "hello"},
    {"senderType": "nanny", "msg": "sdf"},
    {"senderType": "parents", "msg": "165"},
    {"senderType": "nanny", "msg": "re"},
    {"senderType": "parents", "msg": "423"},
    {"senderType": "parents", "msg": "hello"},
    {"senderType": "nanny", "msg": "sdf"},
    {"senderType": "parents", "msg": "165"},
    {"senderType": "nanny", "msg": "re"},
    {"senderType": "parents", "msg": "423"},
  ].obs;

  sendChatMessage() {
    log("on lcick on send chat message called");
    sendMessage(
        toUserId: int.parse(otherUserId.value),
        message: chatTextController.text.trim(),
        date: null,
        fileType: null,
        isFile: false,
        type: 1);
    // final chatProvider = locator<ChatProvider>();
  }

  @override
  void onInit() {
    if (_socketHelper.isConnected == false) {
      _socketHelper.reconnect();
    }
    _socketHelper.hubConnection = _socketHelper.getHubConnection();
    otherUserId.value = Get.arguments;
    update();
    super.onInit();

    log("user id -->> ${otherUserId.value}");
    getNannyDetailsById();
  }

  /// GET NANNY DETAILS
  getNannyDetailsById() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        "id": otherUserId.value,
        "dateTime": DateTime.now().toUtc().toIso8601String(),
      };

      log("get nanny profile body:------ $body");

      _apiHelper.postApi(ApiUrls.nannyDetails, body).futureValue((value) {
        printInfo(info: "post availability nanny  response value $value");
        var response = GetNannyDetailsResponseModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          // isDataLoading.value = false;
          getNannyData = response.data!;
          isOnline.value = getNannyData?.isOnline ?? false;

          update();
        } else {
          // toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      // isDataLoading.value = false;

      printError(info: "post availability  Nanny  API ISSUE $s");
    }
  }

//SEND SINGLE MESSAGE
  sendMessage({
    int? toUserId,
    String? message,
    int? type,
    String? fileType,
    bool? isFile,
    String? date,
  }) async {
    // SendMessage(int ToUserId, string Message, int Type, string FileType,2 bool IsFile, string Date)
    print('Send message data ======> ${[
      toUserId,
      message!,
      type!,
      fileType,
      isFile,
      date
    ].toString()}');
    // String Date =
    //     DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc());

    final result = await _socketHelper.hubConnection.invoke('SendMessage',
        args: [
          toUserId!,
          message,
          type,
          fileType!,
          isFile!,
          date!
        ]).catchError((e) => printInfo(info: e.toString()));
    print('Message sent Received Data ========> ${result.toString()}');

    listenMessage();
    // messageList.add(
    // 0,
    // MessageList(
    //     message: message,
    //     fromUserId: AppLocalStorage().userId,
    //     toUserId: toUserId,
    //     timeStamp: DateFormat('hh:mm a').format(DateTime.now()),
    //     date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    //     isFile: isFile,
    //     isImageFile: isFile,
    //     imageFile: imageFile,
    //     uniqueReference: uniqueReference),
    // );
    // scrollToBottom();
  }

  listenMessage() {
    final result = _socketHelper.hubConnection.on(
      'ReciveMessage',
      (arguments) {
        log("arguments :-->> $arguments");
      },
    );
  }
}
