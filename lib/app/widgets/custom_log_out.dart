import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

import '../res/theme/colors.dart';
import '../res/theme/dimens.dart';

class CustomLogOut extends StatelessWidget {
  const CustomLogOut({super.key, this.onTapLogOut});
  final Function()? onTapLogOut;

  @override
  Widget build(BuildContext context) => Container(
        padding: Dimens.edgeInsets16,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              Dimens.twenty,
            ),
            topRight: Radius.circular(
              Dimens.twenty,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: Dimens.thirty,
              child: Divider(
                color: AppColors.navyBlue,
                thickness: Dimens.four,
                height: Dimens.four,
              ),
            ),
            Dimens.boxHeight20,
            AppText(
              text: TranslationKeys.logSpaceOut.tr,
              style: AppStyles.ubBlack0B0B18W700,
              maxLines: 1,
            ),
            Dimens.boxHeight16,
            AppText(
              text: TranslationKeys.youWantToLeave.tr,
              maxLines: 1,
              style: AppStyles.ub5E5F60Grey14W400,
            ),
            Dimens.boxHeight16,
            CustomButton(
              borderRadius: Dimens.twelve,
              title: TranslationKeys.yes.tr,
              backGroundColor: AppColors.navyBlue,
              onTap: onTapLogOut,
            ),
            Dimens.boxHeight10,
            CustomButton(
              borderRadius: Dimens.twelve,
              title: TranslationKeys.cancel.tr,
              backGroundColor: AppColors.lightNavyBlue,
              titleStyle: AppStyles.ubNavyBlue15W600,
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      );
}
