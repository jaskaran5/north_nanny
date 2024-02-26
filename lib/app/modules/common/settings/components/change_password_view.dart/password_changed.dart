import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class PasswordChangesView extends StatelessWidget {
  const PasswordChangesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Dimens.edgeInsets16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.iconsSuccess,
              alignment: Alignment.center,
              height: Dimens.hundred,
              width: Dimens.hundred,
            ),
            Dimens.boxHeight24,
            AppText(
              text: TranslationKeys.passwordChanged.tr,
              style: AppStyles.ubDarkBlackColor26W700,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            Dimens.boxHeight14,
            SizedBox(
              width: Dimens.twoHundredFifty,
              child: AppText(
                text: TranslationKeys.passwordChangeSuccess.tr,
                style: AppStyles.ubGreyA116W500,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Dimens.boxHeight32,
            CustomButton(
              title: TranslationKeys.backTosetting.tr,
              backGroundColor: AppColors.navyBlue,
              onTap: () {
                RouteManagement.goToOffAllDashboard(isFromSetting: true);
                // Get.to(const SettingView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
