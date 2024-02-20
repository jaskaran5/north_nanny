import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_text_field.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<ForgotPasswordController>(
        builder: (controller) => Scaffold(
          appBar: const CustomAppbarWidget(),
          body: GestureDetector(
            onTap: () {
              Get.focusScope?.unfocus();
            },
            child: Padding(
              padding: Dimens.edgeInsets16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Dimens.boxHeight70,
                  AppText(
                    text: TranslationKeys.createNewPassword.tr,
                    style: AppStyles.pdSemiBoldBlack24,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Dimens.boxHeight14,
                  AppText(
                    text: TranslationKeys.newPasswordMustBeUnique.tr,
                    style: AppStyles.ubGrey16W400,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Dimens.boxHeight32,
                  TextField(
                    // controller: controller.newPasswordTextEditingController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: customFieldDeco(
                      hintText: TranslationKeys.enterNewPassword.tr,
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsLock,
                          height: Dimens.ten,
                          width: Dimens.ten,
                        ),
                      ),
                      suffix: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsShowPassword,
                          height: Dimens.ten,
                          width: Dimens.ten,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.blackColor,
                    cursorWidth: Dimens.one,
                    style: AppStyles.ubBlack15W600,
                  ),
                  Dimens.boxHeight16,
                  TextField(
                    // controller: controller.confirmPasswordTextEditingController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: customFieldDeco(
                      hintText: TranslationKeys.confirmNewPassword.tr,
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsLock,
                          height: Dimens.ten,
                          width: Dimens.ten,
                        ),
                      ),
                      suffix: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsShowPassword,
                          height: Dimens.ten,
                          width: Dimens.ten,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: AppStyles.ubBlack15W600,
                    cursorColor: AppColors.blackColor,
                    cursorWidth: Dimens.one,
                  ),
                  Dimens.boxHeight32,
                  CustomButton(
                    title: TranslationKeys.changePassword.tr,
                    backGroundColor: AppColors.navyBlue,
                    onTap: () {
                      Get.focusScope?.unfocus();
                      RouteManagement.goToPasswordSuccessView();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
