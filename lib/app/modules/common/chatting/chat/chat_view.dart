import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/helper.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';
import 'package:northshore_nanny_flutter/app/widgets/receiver_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/sender_tile.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: HexColor("#F9F9F9"),
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: Dimens.edgeInsets10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: SvgPicture.asset(
                                Assets.iconsBackArrow,
                              ),
                            ),
                            CustomCacheNetworkImage(
                                img: '', size: Dimens.forty),
                            Dimens.boxWidth10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Christina wang',
                                  textAlign: TextAlign.center,
                                  style: AppStyles.ubBlack16W700,
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
                                      style: AppStyles.ubGrey12W400,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SvgPicture.asset(Assets.iconsMore)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: Dimens.edgeInsets10,
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
                  Padding(
                    padding: Dimens.edgeInsetsL16R16B16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * .76,
                          padding: Dimens.edgeInsets4,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
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
                                    Assets.iconsAttachments,
                                  ),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.chatTextController.text.trim() ==
                                '') {
                              showToast(message: "Please Enter your message");
                            } else {
                              controller.sendChatMessage(
                                  message:
                                      controller.chatTextController.text.trim(),
                                  receiverId: 1);
                              controller.chatTextController.text = '';
                            }
                          },
                          child: SvgPicture.asset(
                            Assets.iconsChatSend,
                            height: Dimens.fifty,
                            width: Dimens.fifty,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
