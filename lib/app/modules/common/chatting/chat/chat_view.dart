import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/helper.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';
import 'package:northshore_nanny_flutter/app/widgets/receiver_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/sender_tile.dart';

import '../../../../res/constants/assets.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: HexColor("#F9F9F9"),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: SvgPicture.asset(
                                'assets/icons/back_arrow.svg',
                              ),
                            ),
                            const CustomCacheNetworkImage(img: '', size: 50),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Christina wang',
                                  textAlign: TextAlign.center,
                                  style: AppStyles.B0B0BChristina,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.green,
                                      size: 10,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Online',
                                      textAlign: TextAlign.center,
                                      style: AppStyles.E5F60Online,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: Get.width / 3,
                            ),
                            SvgPicture.asset(Assets.moreIcon)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Visibility(
                        visible: true,
                        replacement: const Center(),
                        child: ListView.builder(
                          reverse: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return controller.chatMessageList[index]
                                        ['senderType'] ==
                                    'parents'
                                ? ReceiverTile(
                                    title: controller.chatMessageList[index]
                                            ['message'] ??
                                        "message",
                                  )
                                : SenderTile(
                                    title: controller.chatMessageList[index]
                                            ['message'] ??
                                        'title',
                                  );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      Container(
                        width: Get.width * .76,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 26),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 6),
                        decoration: BoxDecoration(
                          color: HexColor("#FFFFFF"),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: controller.chatTextController,
                          decoration: InputDecoration(
                              hintText: 'Write a message',
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  Assets.attachementIocn,
                                ),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.chatTextController.text.trim() == '') {
                            showToast(message: "Please Enter your message");
                          } else {
                            controller.sendChatMessage(
                                message:
                                    controller.chatTextController.text.trim(),
                                receiverId: 1);
                            controller.chatTextController.text = '';
                          }
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor("#1B60A5"),
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(Assets.sendIcon),
                                ))),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
