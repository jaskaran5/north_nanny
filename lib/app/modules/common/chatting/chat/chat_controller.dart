import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/chat_other_user_data_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/customer_details_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/get_nanny_details_reponse_model.dart';
import 'package:northshore_nanny_flutter/app/models/send_messgae_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/single_chat_data_response_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/common/socket/singnal_r_socket.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ChatController extends GetxController {
  TextEditingController chatTextController = TextEditingController();

  RxBool isSendMessageVisible = false.obs;

  late KeyboardVisibilityController keyboardVisibilityController;

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
  RxBool isTypingVisible = false.obs;

  UserData? getUserData;

  updateSendMessageVisibility({isVisible}) {
    isSendMessageVisible.value = isVisible;
    update();
  }

  updateTypingVisibility({isVisible}) {
    isTypingVisible.value = isVisible;
    update();
  }

  String isMessageDateEqualToday(String dateTimeString) {
    DateTime providedDate = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));

    for (var value in messageList) {
      if (value.date?.day == providedDate.day &&
          value.date?.month == providedDate.month &&
          value.date?.year == providedDate.year) {
        if (value.date?.day == today.day) {
          log("both are equal");
          return "Today";
        } else if (value.date?.day == yesterday.day) {
          log("both are not equal");

          return "Yesterday";
        } else {
          log("asdfads-->${value.date}");
          log("asdfads-->$today");

          log("both are -----equal${value.date?.day}");
          log("both are -----equal${providedDate.day}");

          log("both are -----equal${value.date?.month}");
          log("both are -----equal${providedDate.month}");

          log("both are -----equal${value.date?.year}");
          log("both are -----equal${providedDate.year}");

          return "${value.date?.day}-${value.date?.month}-${value.date?.year}";
        }
      }
    }
    return "";
  }

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
      DateTime.now().toUtc().toIso8601String()
    ].toString()}');
    // String Date =
    //     DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc());

    // int ToUserId, string Message, int Type, string FileType, bool IsFile, string Date

    final result =
        await _socketHelper.hubConnection.invoke('SendMessage', args: [
      toUserId!,
      message,
      type,
      fileType ?? '',
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
                fileType: res.data?.fileType,
                message: res.data?.messageDescription,
                toUserId: res.data?.toUserId,
                toUserImage: res.data?.toUserImage));

        update();

        Get.find<RecentChatController>().invokedRecentChat();
      },
    );
  }

  listenSocket() {
    listenMessage();
    listenSingleChatDetails();
    listenTyping();
    stopTypingListen();
    listenBlockUnblockUser();
  }

  Future<void> pickDocumentFile() async {
    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx', 'png', 'jpeg', 'jpg', 'pdf', 'mp4'],
    ).then((value) {
      if (value != null) {
        File imageFile = File(value.files.single.path ?? '');
        print("filePath-->${imageFile.path.split(".").last}");
        List<int> imageBytes = imageFile.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);

        log("file is video -->> ${imageFile.path.split('.').last}");
        if (imageFile.path.split('.').last == "mp4") {
          extractThumbnail(imageFile.path);
        }

        DateTime now = DateTime.now();
        int milliseconds = now.millisecondsSinceEpoch;

        sendMessage(
          toUserId: int.parse(otherUserId.value),
          message: base64Image,
          type: 1,
          fileType: imageFile.path.split(".").last,
          isFile: true,
        ).then((_) {
          log("success");
        }).catchError((error) {
          log("error");
        });
      }
    });
  }

  Future<void> extractThumbnail(String videoPath) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 25,
    );

    String imagePath = await saveImage(uint8list!);
    print('Thumbnail saved at: $imagePath');
  }

  Future<String> saveImage(Uint8List imageData) async {
    // Get the temporary directory using path_provider package
    Directory tempDir = await getTemporaryDirectory();

    // Create a temporary file inside the temporary directory
    File imageFile = await File('${tempDir.path}/thumbnail.jpg').create();

    // Write the image data to the temporary file
    await imageFile.writeAsBytes(imageData);

    // Return the path of the saved image file
    return imageFile.path;
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

        messageList.value = res.data?.messageList ?? [];
        messageList.sort((a, b) => b.date!.compareTo(a.date!));
        messageList.refresh();
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
      updateTypingVisibility(isVisible: true);
    });
  }

  //--------->>>>>>>>>    CLEAR CHAT

  clearChat() {
    _socketHelper.hubConnection.invoke("DeleteChat", args: [
      int.parse(otherUserId.value),
      DateTime.now().toUtc().toIso8601String()
    ]);
  }

  //-------->>>>>  STOP TYPING INVOKE
  stopTypingInvoke() {
    _socketHelper.hubConnection
        .invoke("StopTyping", args: [int.parse(otherUserId.value)]);

    log("stop typng invoke called");
  }

  //-------->>>>>  STOP TYPING INVOKE
  stopTypingListen() {
    _socketHelper.hubConnection.on(
      "StopTypingResponse",
      (arguments) {
        updateTypingVisibility(isVisible: false);
        log("stop typing argumnets ---->>>> $arguments");
      },
    );

    log("stop typng invoke called");
  }

  pickDocuments() {
    ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 1000, maxWidth: 1000)
        .then((value) async {
      if (value != null) {
        File imageFile = File(value.path);
        print("filePath-->${imageFile.path.split(".").last}");
        List<int> imageBytes = imageFile.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        DateTime now = DateTime.now();
        int milliseconds = now.millisecondsSinceEpoch;

        // var decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());
        // bool isHorizontalImage = decodedImage.width > decodedImage.height;
        // print("isHorizontalImage-->$isHorizontalImage");
        sendMessage(
          toUserId: int.parse(otherUserId.value),
          message: base64Image,
          type: 1,

          fileType: imageFile.path.split(".").last,
          isFile: true,
          // imageFile: value.path,
          //  uniqueReference: milliseconds.toString(),
        );
        // genderMatchController.scrollToBottom();
      }
    });
  }

  //** COMPRESS VIDEO */

  // Future<MediaInfo?> compressVideo(path) async {
  //   MediaInfo? mediaInfo = await VideoCompress.compressVideo(
  //     path,
  //     quality: VideoQuality.DefaultQuality,
  //     deleteOrigin: false, // It's false by default
  //   );
  //   return mediaInfo;
  // }

  //** block / unblock user */

  blockUnblockUser({isBlock}) {
    _socketHelper.hubConnection
        .invoke("BlockUser", args: [int.parse(otherUserId.value), isBlock]);

    log("blockUnblockUser listen called");
  }

  //** LISTEN block / unblock user */
  listenBlockUnblockUser() {
    _socketHelper.hubConnection.on(
      "BlockUserResponse",
      (arguments) {
        log("block unblock response data:$arguments");
      },
    );

    log("blockUnblockUser listen called");
  }
}
