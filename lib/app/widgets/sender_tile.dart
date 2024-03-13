import 'package:flutter/material.dart';

import '../res/theme/colors.dart';
import '../res/theme/dimens.dart';
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
                color: AppColors.trackerBackgroundColor,
                borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(Dimens.twenty),
                  topRight: Radius.circular(Dimens.twenty),
                  bottomLeft: Radius.circular(Dimens.twenty),
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
