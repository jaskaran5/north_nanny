import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class PasswordSuccessView extends StatelessWidget {
  const PasswordSuccessView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<ForgotPasswordController>(
        builder: (controller) => Scaffold(
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
                  title: TranslationKeys.backToLogIn.tr,
                  backGroundColor: AppColors.navyBlue,
                  onTap: () {
                    RouteManagement.goToOffAllLogIn();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
