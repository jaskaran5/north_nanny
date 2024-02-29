import 'package:flutter/material.dart';

import 'custom_receiver_chat_time_tile.dart';

class ReceiverTile extends StatelessWidget {
  const ReceiverTile({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10, right: 50),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Text(
                title!,
                textAlign: TextAlign.left,
              ),
            ),
            const CustomReceiverChatTimeTile(
              text: "7:31 PM",
            )
          ],
        ),
      ),
    );
  }
}
