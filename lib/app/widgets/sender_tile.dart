import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_receiver_chat_time_tile.dart';

import 'custom_sender_chat_time_tile.dart';

class SenderTile extends StatelessWidget {
  const SenderTile({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
          // margin: const EdgeInsets.only(bottom: 38, left: 50),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: HexColor("#1B60A5"),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Text(
                title!,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.left,
              ),


            ),
            const CustomSenderChatTimeTile(
              text: "7:31 PM",

            )
          ],
        ),
      ),
    );
  }
}
