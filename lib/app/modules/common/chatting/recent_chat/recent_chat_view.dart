import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_recant_chat_list.dart';

class RecentChatView extends StatelessWidget {
  RecentChatView({super.key}) {
    // print("RecentChatView");
    // contrller.invokedRecentChat();
  }
  // final contrller = Get.put(RecentChatController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RecentChatController(),
        builder: (RecentChatController controller) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Messages",
                              style: AppStyles.pdNormal,
                            ),
                            Container(
                              height: Dimens.forty,
                              width: Dimens.forty,
                              decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: Dimens.twentyFive,
                              ),
                            )
                          ],
                        ),
                      ),
                      Dimens.boxHeight10,
                      //check
                      ListView.builder(
                        itemCount: 16,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Color textColor =
                              index % 2 == 0 ? Colors.black : Colors.blue;

                          return const CustomeReectChatListTile();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
