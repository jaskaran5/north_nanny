import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';

class CustomRichText extends StatelessWidget {
  final String firstTxt;
  final String lastTxt;

  const CustomRichText({
    super.key,
    required this.firstTxt,
    required this.lastTxt,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstTxt,
        style: AppStyles.ubBlack12W500,
        children: <TextSpan>[
          TextSpan(
            text: " $lastTxt",
            style: AppStyles.ubGrey12W400,
          ),
        ],
      ),
    );
  }
}
