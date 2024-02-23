import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';

import '../res/theme/dimens.dart';

class CustomSettingItemTile extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final String leadingIcon;
  final String trallingIcon;

  const CustomSettingItemTile(
      {super.key,
      required this.onTap,
      required this.text,
      required this.trallingIcon,
      required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Dimens.edgeInsets16,
        margin: Dimens.edgeInsetsT10,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(Dimens.ten),
          boxShadow: [
            BoxShadow(
              color: AppColors.settingBackgroundColor.withOpacity(.18),
              blurRadius: Dimens.fifteen,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  leadingIcon,
                  height: Dimens.twentyFour,
                  width: Dimens.twentyFour,
                ),
                Dimens.boxWidth10,
                Text(
                  text,
                  style: AppStyles.ubBlack14W600,
                  maxLines: 1,
                ),
              ],
            ),
            SvgPicture.asset(trallingIcon),
          ],
        ),
      ),
    );
  }
}
