import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/controllers.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/utils/navigators/navigators.dart';
import 'package:northshore_nanny_flutter/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/widgets/custom_button.dart';

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
                    RouteManagement.goToLogIn();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
