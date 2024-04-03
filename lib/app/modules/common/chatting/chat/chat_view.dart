import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lottie/lottie.dart';
import 'package:northshore_nanny_flutter/app/models/single_chat_data_response_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat/chat_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/chat_image_view.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/pdf/pdf_viwer.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/video_player/video_player.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';
import 'package:northshore_nanny_flutter/app/widgets/receiver_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/sender_tile.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        return KeyboardVisibilityBuilder(
          builder: (ctx, isKeyboardVisible) {
            if (isKeyboardVisible) {
              controller.typingInvoke();
            } else if (!isKeyboardVisible) {
              controller.stopTypingInvoke();
            }
            log("is keyboard visible:---->>. $isKeyboardVisible");
            return Scaffold(
              backgroundColor: AppColors.profileBackgroundColor,
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
                                  controller.invokeReadMessage().then((value) {
                                    Get.back(result: "true");
                                  });
                                },
                                icon: SvgPicture.asset(
                                  Assets.iconsBackArrow,
                                ),
                              ),
                              CustomCacheNetworkImage(
                                img: controller.getUserData?.image ?? '',
                                size: Dimens.forty,
                                imageRadius: Dimens.hundred,
                              ),
                              Dimens.boxWidth10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width * .55,
                                    child: Text(
                                      controller.getUserData?.name ?? '',
                                      textAlign: TextAlign.start,
                                      style: AppStyles.ubBlack16W700,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: controller.isOnline.value
                                            ? AppColors.onlineColor
                                            : Colors.red,
                                        size: 10,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        controller.isOnline.value
                                            ? 'Online'
                                            : 'offline',
                                        textAlign: TextAlign.center,
                                        style: AppStyles.ubGrey12W400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          PopupMenuButton(
                            padding: Dimens.edgeInsets0,
                            position: PopupMenuPosition.under,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Dimens.eight),
                            ),
                            icon: SvgPicture.asset(Assets.iconsMore),
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  onTap: () {
                                    controller.clearChat();
                                  },
                                  child: const Text("Clear Chat"),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    controller.blockUnblockUser();
                                  },
                                  child: Text(
                                    controller.isBlockByMe.value
                                        ? "UnBlock"
                                        : "Block",
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    ),
                    controller.messageList.isNotEmpty
                        ? Expanded(
                            child: Padding(
                              padding: Dimens.edgeInsets10,
                              child: Stack(
                                children: [
                                  GroupedListView<MessageList, String>(
                                    sort: false,
                                    elements: controller.messageList,
                                    shrinkWrap: true,
                                    reverse: true,
                                    groupHeaderBuilder: (element) {
                                      return Text(
                                        controller.isMessageDateEqualToday(
                                            element.date.toString()),
                                        textAlign: TextAlign.center,
                                      );
                                    },
                                    groupBy: (message) =>
                                        Utility.convertStringToDateFormatDDMMYY(
                                            message.date.toString()),
                                    groupSeparatorBuilder:
                                        (String groupByValue) => Text(Utility
                                            .convertStringToDateFormatDDMMYY(
                                                groupByValue)),
                                    itemBuilder: (context, messageList) {
                                      return messageList.toUserId ==
                                              controller.myUserId.value
                                          ? ReceiverTile(
                                              thumbImage:
                                                  messageList.thumbImage,
                                              onTapOnPdf: () {
                                                Get.to(PDFScreen(
                                                  path: messageList.fileLink,
                                                ));
                                              },
                                              onTapOnVideo: () {
                                                Get.to(VideoPlayerView(
                                                  url: messageList.fileLink,
                                                ));
                                              },
                                              fileType: messageList.fileType,
                                              isFile:
                                                  messageList.isFile ?? false,
                                              fileLink:
                                                  messageList.fileLink!.isEmpty
                                                      ? null
                                                      : messageList.fileLink,
                                              time: messageList.date.toString(),
                                              title: messageList.message ?? '',
                                            )
                                          : SenderTile(
                                              thumbImage:
                                                  messageList.thumbImage,
                                              onTapOnImage: () {
                                                Get.to(() => FullViewImage(
                                                      url: messageList.fileLink,
                                                    ));
                                              },
                                              onTapOnPdf: () {
                                                Get.to(PDFScreen(
                                                  path: messageList.fileLink,
                                                ));
                                              },
                                              onTapOnVideo: () {
                                                Get.to(VideoPlayerView(
                                                  url: messageList.fileLink,
                                                ));
                                              },
                                              fileType: messageList.fileType,
                                              isFile:
                                                  messageList.isFile ?? false,
                                              fileLink: messageList.fileLink,
                                              time: messageList.date.toString(),
                                              title: messageList.message ?? "",
                                            );
                                    },
                                    itemComparator: (item1, item2) =>
                                        Utility.convertStringToDateFormatDDMMYY(
                                                item1.date.toString())
                                            .compareTo(
                                      Utility.convertStringToDateFormatDDMMYY(
                                        item2.date.toString(),
                                      ),
                                    ), // optional
                                    useStickyGroupSeparators: true,
                                    floatingHeader: true,
                                    // order: GroupedListOrder.DESC, // optional
                                  ),
                                  Visibility(
                                    visible: controller.isLoading.value,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: Center(
                                child: Text(
                              'Please Send Message to Start Conversation',
                              style: AppStyles.b0b0fairPlay15w600,
                            )),
                          ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Visibility(
                        visible: controller.isTypingVisible.value,
                        child: Padding(
                          padding: Dimens.edgeInsetsL16R16B16,
                          child: Lottie.asset(
                            Assets.animationTypingIndicatorAnimation,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    ((!controller.isBlockByOtherUser.value) ||
                            (!controller.isBlockByMe.value))
                        ? Padding(
                            padding: Dimens.edgeInsetsL16R16B16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: controller.isSendMessageVisible.value
                                      ? Get.width * .76
                                      : Get.width * .9,
                                  padding: Dimens.edgeInsets4,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      if (value.trim().isNotEmpty) {
                                        controller.updateSendMessageVisibility(
                                            isVisible: true);
                                      } else {
                                        controller.updateSendMessageVisibility(
                                            isVisible: false);
                                      }
                                    },
                                    controller: controller.chatTextController,
                                    decoration: InputDecoration(
                                      hintText: 'Write a message',
                                      border: InputBorder.none,
                                      prefixIcon: IconButton(
                                        icon: SvgPicture.asset(
                                          Assets.iconsAttachments,
                                          fit: BoxFit.cover,
                                          height: Dimens.twentyFive,
                                          width: Dimens.twentyFive,
                                        ),
                                        onPressed: () {
                                          log("on click on pick document");
                                          // controller.pickDocuments();
                                          controller.pickDocumentFile();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      controller.isSendMessageVisible.value,
                                  child: InkWell(
                                    onTap: () async {
                                      if (controller.chatTextController.text
                                              .trim() ==
                                          '') {
                                        toast(
                                          msg: '"Please Enter your message"',
                                          isError: true,
                                        );
                                      } else {
                                        log("else part called");
                                        controller.sendMessage(
                                          toUserId: int.parse(
                                            controller.otherUserId.value
                                                .toString(),
                                          ),
                                          message: controller
                                              .chatTextController.text
                                              .trim(),
                                          fileType: null,
                                          isFile: false,
                                          type: 1,
                                        );
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      Assets.iconsChatSend,
                                      height: Dimens.fifty,
                                      width: Dimens.fifty,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            margin: Dimens.edgeInsets10,
                            child: Text(
                              controller.isBlockByOtherUser.value
                                  ? "You Can't send message"
                                  : controller.isBlockByMe.value
                                      ? "You have blocked this customer. Please unblock to chat again"
                                      : '',
                              style: AppStyles.b0b0fairPlay15w600,
                            ),
                          )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}



// class ChatView extends StatelessWidget {
//   const ChatView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ChatController>(
//       init: ChatController(),
//       builder: (controller) {
//         return KeyboardVisibilityBuilder(
//           builder: (ctx, isKeyboardVisible) {
//             if (isKeyboardVisible) {
//               controller.typingInvoke();
//             } else if (!isKeyboardVisible) {
//               controller.stopTypingInvoke();
//             }
//             log("is keyboard visible:---->>. $isKeyboardVisible");
//             return Scaffold(
//                 backgroundColor: AppColors.profileBackgroundColor,
//                 body: SafeArea(
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: Dimens.edgeInsets10,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   onPressed: () {
//                                     controller
//                                         .invokeReadMessage()
//                                         .then((value) {
//                                       Get.back(result: "true");
//                                     });
//                                   },
//                                   icon: SvgPicture.asset(
//                                     Assets.iconsBackArrow,
//                                   ),
//                                 ),
//                                 CustomCacheNetworkImage(
//                                   img: controller.getUserData?.image ?? '',
//                                   size: Dimens.forty,
//                                   imageRadius: Dimens.hundred,
//                                 ),
//                                 Dimens.boxWidth10,
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       width: Get.width * .55,
//                                       child: Text(
//                                         controller.getUserData?.name ?? '',
//                                         textAlign: TextAlign.start,
//                                         style: AppStyles.ubBlack16W700,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.circle,
//                                           color: controller.isOnline.value
//                                               ? AppColors.onlineColor
//                                               : Colors.red,
//                                           size: 10,
//                                         ),
//                                         const SizedBox(
//                                           width: 4,
//                                         ),
//                                         Text(
//                                           controller.isOnline.value
//                                               ? 'Online'
//                                               : 'offline',
//                                           textAlign: TextAlign.center,
//                                           style: AppStyles.ubGrey12W400,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),

//                             PopupMenuButton(
//                               padding: Dimens.edgeInsets0,
//                               position: PopupMenuPosition.under,
//                               elevation: 2,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.circular(Dimens.eight)),
//                               icon: SvgPicture.asset(Assets.iconsMore),
//                               itemBuilder: (BuildContext context) {
//                                 return [
//                                   PopupMenuItem(
//                                       onTap: () {
//                                         controller.clearChat();
//                                       },
//                                       child: const Text("Clear Chat")),
//                                   PopupMenuItem(
//                                       onTap: () {
//                                         controller.blockUnblockUser();
//                                       },
//                                       //
//                                       child: Text(
//                                         controller.isBlockByMe.value
//                                             ? "UnBlock"
//                                             : "Block",
//                                         style:
//                                             const TextStyle(color: Colors.red),
//                                       )),
//                                 ];
//                               },
//                             ),
//                             // GestureDetector(
//                             //   child: SvgPicture.asset(Assets.iconsMore),
//                             // )
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: Dimens.edgeInsets10,
//                           child: Visibility(
//                             visible: true,
//                             replacement: const Center(),
//                             child: Stack(
//                               children: [
//                                 Expanded(
//                                   child: GroupedListView<MessageList, String>(
//                                     sort: false,
//                                     elements: controller.messageList,
//                                     shrinkWrap: true,
//                                     reverse: true,

//                                     groupHeaderBuilder: (element) {
//                                       return Text(
//                                         controller.isMessageDateEqualToday(
//                                             element.date.toString()),
//                                         textAlign: TextAlign.center,
//                                       );
//                                     },
//                                     groupBy: (message) =>
//                                         Utility.convertStringToDateFormatDDMMYY(
//                                             message.date.toString()),
//                                     groupSeparatorBuilder:
//                                         (String groupByValue) => (Text(Utility
//                                             .convertStringToDateFormatDDMMYY(
//                                                 groupByValue))),
//                                     itemBuilder: (context, messageList) {
//                                       return messageList.toUserId ==
//                                               controller.myUserId.value
//                                           ? ReceiverTile(
//                                               thumbImage:
//                                                   messageList.thumbImage,
//                                               onTapOnPdf: () {
//                                                 Get.to(PDFScreen(
//                                                   path: messageList.fileLink,
//                                                 ));
//                                               },
//                                               onTapOnVideo: () {
//                                                 Get.to(VideoPlayerView(
//                                                   url: messageList.fileLink,
//                                                 ));
//                                               },
//                                               fileType: messageList.fileType,
//                                               isFile:
//                                                   messageList.isFile ?? false,
//                                               fileLink:
//                                                   messageList.fileLink!.isEmpty
//                                                       ? null
//                                                       : messageList.fileLink,
//                                               time: messageList.date.toString(),
//                                               title: messageList.message ?? '',
//                                             )
//                                           : SenderTile(
//                                               thumbImage:
//                                                   messageList.thumbImage,
//                                               onTapOnImage: () {
//                                                 Get.to(() => FullViewImage(
//                                                       url: messageList.fileLink,
//                                                     ));
//                                               },
//                                               onTapOnPdf: () {
//                                                 Get.to(PDFScreen(
//                                                   path: messageList.fileLink,
//                                                 ));
//                                               },
//                                               onTapOnVideo: () {
//                                                 Get.to(VideoPlayerView(
//                                                   url: messageList.fileLink,
//                                                 ));
//                                               },
//                                               fileType: messageList.fileType,
//                                               isFile:
//                                                   messageList.isFile ?? false,
//                                               fileLink: messageList.fileLink,
//                                               time: messageList.date.toString(),
//                                               title: messageList.message ?? "");
//                                     },
//                                     itemComparator: (item1, item2) => Utility
//                                             .convertStringToDateFormatDDMMYY(
//                                                 item1.date.toString())
//                                         .compareTo(Utility
//                                             .convertStringToDateFormatDDMMYY(
//                                                 item2.date
//                                                     .toString())), // optional
//                                     useStickyGroupSeparators: true,
//                                     floatingHeader: true,
//                                     // order: GroupedListOrder.DESC, // optional
//                                   ),
//                                 ),
//                                 Visibility(
//                                     visible: controller.isLoading.value,
//                                     child: const Center(
//                                         child: CircularProgressIndicator()))
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Visibility(
//                           visible: controller.isTypingVisible.value,
//                           child: Padding(
//                             padding: Dimens.edgeInsetsL16R16B16,
//                             child: Lottie.asset(
//                                 Assets.animationTypingIndicatorAnimation,
//                                 fit: BoxFit.cover),
//                           ),
//                         ),
//                       ),
//                       !controller.isBlockByOtherUser.value
//                           ? Padding(
//                               padding: Dimens.edgeInsetsL16R16B16,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width: controller.isSendMessageVisible.value
//                                         ? Get.width * .76
//                                         : Get.width * .9,
//                                     padding: Dimens.edgeInsets4,
//                                     decoration: BoxDecoration(
//                                       color: AppColors.primaryColor,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: TextFormField(
//                                       onChanged: (value) {
//                                         if (value.trim().isNotEmpty) {
//                                           controller
//                                               .updateSendMessageVisibility(
//                                                   isVisible: true);
//                                         } else {
//                                           controller
//                                               .updateSendMessageVisibility(
//                                                   isVisible: false);
//                                         }
//                                       },
//                                       controller: controller.chatTextController,
//                                       decoration: InputDecoration(
//                                           hintText: 'Write a message',
//                                           border: InputBorder.none,
//                                           prefixIcon: IconButton(
//                                             icon: SvgPicture.asset(
//                                               Assets.iconsAttachments,
//                                               fit: BoxFit.cover,
//                                               height: Dimens.twentyFive,
//                                               width: Dimens.twentyFive,
//                                             ),
//                                             onPressed: () {
//                                               log("on click on pick document");
//                                               // controller.pickDocuments();
//                                               controller.pickDocumentFile();
//                                             },
//                                           )),
//                                     ),
//                                   ),
//                                   Visibility(
//                                     visible:
//                                         controller.isSendMessageVisible.value,
//                                     child: InkWell(
//                                       onTap: () async {
//                                         if (controller.chatTextController.text
//                                                 .trim() ==
//                                             '') {
//                                           toast(
//                                               msg:
//                                                   '"Please Enter your message"',
//                                               isError: true);
//                                         } else {
//                                           log("else part called");
//                                           controller.sendMessage(
//                                               toUserId: int.parse(controller
//                                                   .otherUserId.value
//                                                   .toString()),
//                                               message: controller
//                                                   .chatTextController.text
//                                                   .trim(),
//                                               fileType: null,
//                                               isFile: false,
//                                               type: 1);
//                                         }
//                                       },
//                                       child: SvgPicture.asset(
//                                         Assets.iconsChatSend,
//                                         height: Dimens.fifty,
//                                         width: Dimens.fifty,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : Container(
//                               margin: Dimens.edgeInsets10,
//                               child: Text(
//                                 "You Can't send message",
//                                 style: AppStyles.b0b0fairPlay15w600,
//                               ),
//                             )
//                     ],
//                   ),
//                 ));
//           },
//         );
//       },
//     );
//   }

//   Widget chatManageWidget() {
//     return Container();
//   }
// }


