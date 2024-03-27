import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/models/chat_list_response_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/date_helper.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_new_message_count_icon.dart';

import '../modules/common/chatting/recent_chat/recent_chat_controller.dart';

class CustomRecentChatListTile extends StatelessWidget {
  const CustomRecentChatListTile({
    super.key,
    required this.chatData,
    required this.image,
  });
  final ChatList? chatData;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecentChatController>(
        init: RecentChatController(),
        builder: (controller) {
          return Padding(
            padding: Dimens.edgeInsets12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(children: [
                  (chatData!.image!.isNotEmpty)
                      ? CustomCacheNetworkImage(
                          img: chatData!.image!,
                          size: Dimens.fifty,
                          imageRadius: Dimens.fifty)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            Assets.imagesUserAvatar,
                            height: Dimens.fifty,
                            width: Dimens.fifty,
                            fit: BoxFit.cover,
                          ),
                        ),
                  Positioned(
                    bottom: 2,
                    right: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(Dimens.ten)),
                      child: Icon(
                        Icons.circle,
                        color: chatData!.isOnline!
                            ? AppColors.onlineColor
                            : AppColors.offlineColor,
                        size: Dimens.ten,
                      ),
                    ),
                  )
                ]),
                Dimens.boxWidth10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * .5,
                      child: Text(
                        chatData?.fullName ?? '',
                        style: chatData?.unreadMessageCount == 0
                            ? AppStyles.ubBlack14W700
                            : AppStyles.ubNavyBlue14W700,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Dimens.boxHeight8,
                    chatData!.isLastMessageImage!
                        ? _buildFileWidget(fileType: chatData?.fileType ?? '')
                        : SizedBox(
                            width: Get.width * .5,
                            child: Text(
                              chatData?.lastMessage ?? '',
                              style: chatData?.unreadMessageCount == 0
                                  ? AppStyles.ubGrey12W500
                                  : AppStyles.ubBlack12W600,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      DateHelper.getDateTimeAgo(chatData!.dateTime.toString()),
                      style: AppStyles.ubChatTimeColor12W400,
                    ),
                    Dimens.boxHeight8,
                    chatData?.unreadMessageCount != 0
                        ? CustomNewMessageCountIcon(
                            count: chatData!.unreadMessageCount.toString(),
                          )
                        : const SizedBox()
                  ],
                )
              ],
            ),
          );
        });
  }

  Widget _buildFileWidget({fileType}) {
    log("file type in recent chat is:--$fileType");
    if ((fileType == "jpg") || (fileType == "jpeg") || (fileType == "png")) {
      return const Icon(Icons.image);
    } else if ((fileType == "pdf") || (fileType == "docx")) {
      return const Icon(
        Icons.picture_as_pdf,
      );
    } else if (fileType == "mp4") {
      // Show video player widget here
      return const Icon(
        Icons.slow_motion_video_outlined,
        color: Colors.black,
        size: 25,
      ); // Replace this with your video player widget
    } else {
      return const SizedBox();
    }
  }
}
