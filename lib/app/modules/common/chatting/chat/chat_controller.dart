import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  TextEditingController chatTextController = TextEditingController();

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

  sendChatMessage({
    String? message,
    int? receiverId,
    String? messageType = 'Text',
  }) {
    // final chatProvider = locator<ChatProvider>();
  }
}
