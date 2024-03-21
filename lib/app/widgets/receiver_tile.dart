import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';

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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimens.fifteen),
                  topRight: Radius.circular(Dimens.fifteen),
                  bottomRight: Radius.circular(Dimens.fifteen),
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
