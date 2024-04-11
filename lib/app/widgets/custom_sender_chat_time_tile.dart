import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';

class CustomSenderChatTimeTile extends StatelessWidget {
  final String text;
  final bool isRead;
  const CustomSenderChatTimeTile({
    super.key,
    required this.text,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: isRead ? 'Read ' : 'Delivered',
        style:isRead? AppStyles.ubGrey3b3c42f10w600:AppStyles.ub8F94AE10W400,
        children: <TextSpan>[
          if (isRead)
            TextSpan(text: text, style: AppStyles.ubGrey3b3c42f10w400),
        ],
      ),
    );

    // Text(text,style: AppStyles.ubGrey3b3c42f10w400,);
  }
}
