import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/chat_other_user_data_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/customer_details_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/get_nanny_details_reponse_model.dart';
import 'package:northshore_nanny_flutter/app/models/send_messgae_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/single_chat_data_response_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/socket/singnal_r_socket.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';

class ChatController extends GetxController {
  TextEditingController chatTextController = TextEditingController();
  final ApiHelper _apiHelper = ApiHelper.to;
  final _socketHelper = SignalRHelper();

  RxBool isSkeletonizer = true.obs;

  RxString loginType = ''.obs;
  RxInt myUserId = 0.obs;

  RxList<MessageList> messageList = <MessageList>[].obs;
  // SingleChatData? singleChatData;

  //

  RxString otherUserId = ''.obs;
  RxBool isOnline = false.obs;

  UserData? getUserData;

  sendChatMessage() {
    log("on lcick on send chat message called");
    sendMessage(
        toUserId: int.parse(otherUserId.value),
        message: chatTextController.text.trim(),
        fileType: null,
        isFile: false,
        type: 1);
    // final chatProvider = locator<ChatProvider>();
  }

  Future<void> getLoginType() async {
    loginType.value = await Storage.getValue(StringConstants.loginType);
    myUserId.value = await Storage.getValue(StringConstants.userId);
    update();

    loginType.value == StringConstants.customer
        ? getNannyDetailsById()
        : getCustomerDetailsById();
  }

  @override
  void onInit() {
    getLoginType().then((value) => null);

    if (_socketHelper.isConnected == false) {
      _socketHelper.reconnect();
    }
    _socketHelper.hubConnection = _socketHelper.getHubConnection();
    otherUserId.value = Get.arguments;
    update();
    super.onInit();

    log("user id -->> ${otherUserId.value}");

    listenSocket();

    getSingleChatDetails();
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

          getUserData = UserData(
              image: response.data?.image ?? '',
              isOnline: response.data?.isOnline ?? false,
              name: response.data?.name ?? '');
          isOnline.value = response.data?.isOnline ?? false;

          update();

          print("get user data -->> $getUserData");
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
  }) async {
    // SendMessage(int ToUserId, string Message, int Type, string FileType,2 bool IsFile, string Date)
    print('Send message data ======> ${[
      toUserId,
      message!,
      type!,
      fileType,
      isFile,
      DateTime.now().toUtc()
    ].toString()}');
    // String Date =
    //     DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc());

    final result = await _socketHelper.hubConnection.invoke('SendMessage',
        args: [
          toUserId!,
          message,
          type,
          "",
          isFile!,
          DateTime.now().toUtc().toIso8601String()
        ]);
    print('Message sent Received Data ========> ${result.toString()}');
  }

//listen send message
  listenMessage() {
    final result = _socketHelper.hubConnection.on(
      'ReciveMessage',
      (arguments) {
        log("arguments :-->> $arguments");

        var data = arguments?[0] as Map<String, dynamic>;

        var res = SendMessageResponseModel.fromJson(data);
        messageList.insert(
            0,
            MessageList(
                date: res.data?.time ?? DateTime.now(),
                fileLink: res.data?.fileLink ?? '',
                fromUserId: myUserId.value,
                id: res.data?.chatId,
                isChatDeleted: '',
                isFile: res.data?.isFile,
                message: res.data?.messageDescription,
                toUserId: res.data?.toUserId,
                toUserImage: res.data?.toUserImage));

        update();
      },
    );
  }

  listenSocket() {
    listenMessage();
    listenSingleChatDetails();
    listenTyping();
  }

  /// PICK DOCUMENT FILES
  pickDocumentFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx', 'pdf', 'png', 'jpeg', 'jpg', 'pdf', 'mp4'],
    );
  }

  // INVOKE SINGLE CHAT DETAILS

  getSingleChatDetails() async {
    final result = await _socketHelper.hubConnection
        .invoke("ChatDetail", args: [int.parse(otherUserId.value)]);
  }

  //========--------->>>>>>>>>>>>>>> LISTER SINGLE CHAT DATA

  listenSingleChatDetails() {
    final result = _socketHelper.hubConnection.on(
      'ChatDetailResponse',
      (arguments) {
        log("arguments :-->> $arguments");

        var data = arguments?[0] as Map<String, dynamic>;

        var res = SingleChatDataResponseModel.fromJson(data);

        messageList.value = (res.data?.messageList ?? []).reversed.toList();
        isSkeletonizer.value = false;

        update();
      },
    );
  }

  /// GET CUSTOMER BY ID
  getCustomerDetailsById() async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      var body = {
        "userId": otherUserId.value,
      };

      log("get nanny profile body:------ $body");

      _apiHelper.postApi(ApiUrls.getCustomerProfileById, body).futureValue(
          (value) {
        printInfo(info: "post availability nanny  response value $value");
        var response = CustomerDetailsResponseModel.fromJson(value);

        log("response.response :${response.response}");
        if (response.response == AppConstants.apiResponseSuccess) {
          log("success called-----------");
          getUserData = UserData(
              image: response.data?.image ?? '',
              isOnline: response.data?.isOnline ?? false,
              name: response.data?.name ?? '');
          // getNannyData = response;
          isOnline.value = response.data?.isOnline ?? false;

          update();

          print("get user data -->> $getUserData");
        } else {}
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);

      printError(info: "post availability  Nanny  API ISSUE $s");
    }
  }

//---------->>>>>>>>>>.... TYPING INVOKE
  typingInvoke() {
    _socketHelper.hubConnection
        .invoke("Typing", args: [int.parse(otherUserId.value)]);

    log("typing invoke called");
  }

//--------->>>>>>>>>>>>>>>>> LISTEN INVOKE
  listenTyping() {
    _socketHelper.hubConnection.on("TypingResponse", (arguments) {
      log("typing response argumnets-->. $arguments");
    });
  }

  //--------->>>>>>>>>    CLEAR CHAT

  clearChat() {
    _socketHelper.hubConnection.invoke("DeleteChat", args: [
      int.parse(otherUserId.value),
      DateTime.now().toUtc().toIso8601String()
    ]);
  }
}
