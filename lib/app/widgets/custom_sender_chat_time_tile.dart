import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';

class CustomSenderChatTimeTile extends StatelessWidget {
  final String text;
  const CustomSenderChatTimeTile({super.key, required this.text,});

  @override
  Widget build(BuildContext context) {
    return

      RichText(
        text: TextSpan(
          text: 'Read ',
          style:AppStyles. ubGrey3b3c42f10w600,
          children: <TextSpan>[
            TextSpan(
                text: text,
                style: AppStyles.ubGrey3b3c42f10w400),
          ],
        ),
      );



      // Text(text,style: AppStyles.ubGrey3b3c42f10w400,);
  }
}
