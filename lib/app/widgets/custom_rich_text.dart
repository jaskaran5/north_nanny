import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';

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
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        children: <TextSpan>[
          TextSpan(
              text: " $lastTxt",
              style: const TextStyle(color: AppColors.hintColor)),
        ],
      ),
    );
  }
}
