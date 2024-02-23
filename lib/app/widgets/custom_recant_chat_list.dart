import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';

class CustomeReectChatListTile extends StatelessWidget {
  const CustomeReectChatListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecentChatController>(
        init: RecentChatController(),
        builder: (controller) {
          return Padding(
            padding: Dimens.edgeInsets12,
            child: GestureDetector(
              onTap: () {
                controller.redirectToChatScreen();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        "https://media.istockphoto.com/id/1358464345/photo/mare-and-foal.jpg?s=612x612&w=0&k=20&c=K_yKzFMHEWckTpYN-LJMo7jUDdNR5Gndk5ZYSaXnTwI=",
                        height: 55,
                        width: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Positioned(
                          bottom: 2,
                          right: 3,
                          child: Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 14,
                          ),
                        ),
                      ),
                    )
                  ]),
                  Dimens.boxWidth10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Deepak Thursday",
                        style: AppStyles.ubBlack14W700,
                        maxLines: 1,
                      ),
                      Text(
                        "oh my god please help me",
                        style: AppStyles.ubGrey12W500,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "5m ago",
                        style: AppStyles.ubChatTimeColor12W400,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
