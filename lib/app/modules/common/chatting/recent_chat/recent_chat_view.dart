import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:northshore_nanny_flutter/app/modules/common/chatting/recent_chat/recent_chat_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';

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
                      Row(
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                      ListView.builder(
                        itemCount: 16,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Color textColor =
                              index % 2 == 0 ? Colors.black : Colors.blue;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                controller.redirectToChatScreen();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    const Positioned(
                                      bottom: 3,
                                      right: 3,
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.blue,
                                        size: 10,
                                      ),
                                    )
                                  ]),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Deepak Thursday",
                                          style: AppStyles.navyBlueUrbanist14),
                                      const Text(
                                        "oh my god please help me",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "5m ago",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
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
