import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';

class CustomSubmitButton extends StatelessWidget {
  final String btnText;

  const CustomSubmitButton({super.key, required this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Dimens.edgeInsets8_0,
      height: Get.height * .075,
      alignment: Alignment.center,
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColors.greyColor134373,
          borderRadius: BorderRadius.circular(Dimens.twelve)),
      child: Padding(
        padding: Dimens.edgeInsets16,
        child: Text(
          btnText,
          style: AppStyles.btnTextStyle,
        ),
      ),
    );
  }
}
