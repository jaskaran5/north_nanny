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
                        style: AppStyles.ubBlack14W700,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Dimens.boxHeight8,
                    SizedBox(
                      width: Get.width * .5,
                      child: Text(
                        chatData?.lastMessage ?? '',
                        style: AppStyles.ubGrey12W500,
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
}
