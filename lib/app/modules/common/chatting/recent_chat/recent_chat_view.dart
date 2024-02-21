import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_recant_chat_list.dart';

class RecentChatView extends StatelessWidget {
  const RecentChatView({super.key});

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
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
