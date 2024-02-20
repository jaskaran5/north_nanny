import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_controller.dart';
import 'package:northshore_nanny_flutter/app/utils/helper.dart';
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
            backgroundColor: Colors.grey,
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 16),
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
                            // const CustomCacheNetworkImage(img: '', size: 50),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      '',
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Christina wang',
                                  textAlign: TextAlign.center,
                                  // style: titleStyle
                                  //     .copyWith(
                                  // //       fontSize: 16,
                                  //     )
                                  //     .usePoppinsW5Font(),
                                ),
                                Text(
                                  'Active now',
                                  textAlign: TextAlign.center,
                                  // style: titleStyle
                                  //     .copyWith(fontSize: 12, color: greyB6B6B6)
                                  //     .usePoppinsW4Font(),
                                ),
                              ],
                            ),
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
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.chatTextController,
                          decoration: const InputDecoration(
                              hintText: 'Enter message...',
                              border: InputBorder.none,
                              prefixIcon:
                                  Icon(Icons.dashboard_customize_rounded)),
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
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.send),
                                ))
                            // SvgPicture.asset(
                            //   'assets/icons/home/ic_send.svg',
                            // ),
                            ),
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
