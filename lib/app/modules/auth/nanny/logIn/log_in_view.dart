import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/nanny/logIn/log_in_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_text_field.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<LogInController>(
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: Get.focusScope?.unfocus,
            child: Padding(
              padding: Dimens.edgeInsets16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Dimens.boxHeight70,
                          AppText(
                            text: TranslationKeys.welComeBackGlad.tr,
                            style: AppStyles.pdSemiBoldBlack24,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Dimens.boxHeight14,
                          AppText(
                            text: TranslationKeys.enterLogInInfo.tr,
                            style: AppStyles.ubGrey16W400,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Dimens.boxHeight32,
                          /** EMAIL============= */
                          TextField(
                            controller: controller.emailTextEditingController,
                            maxLines: 1,
                            minLines: 1,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.enterEmail.tr,
                              prefixWidget: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsEmail,
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

                          /** PASSWORD ============ */
                          TextField(
                            obscureText: !controller.isPasswordVisible.value,
                            controller:
                                controller.passwordTextEditingController,
                            maxLines: 1,
                            minLines: 1,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.enterPassword.tr,
                              suffix: GestureDetector(
                                onTap: () {
                                  controller.togglePassword();
                                },
                                child: Padding(
                                  padding: Dimens.edgeInsets12,
                                  child: SvgPicture.asset(
                                    controller.isPasswordVisible.value
                                        ? Assets.iconsHide
                                        : Assets.iconsShow,
                                    height: Dimens.ten,
                                    width: Dimens.ten,
                                  ),
                                ),
                              ),
                              prefixWidget: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsLock,
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
                          Dimens.boxHeight16,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /** CHECK BOX */
                                  Container(
                                    width: Dimens.twenty,
                                    height: Dimens.twenty,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(Dimens.four),
                                    ),
                                    child: Checkbox(
                                      value: controller.rememberMe.value,
                                      activeColor: AppColors.navyBlue,
                                      onChanged: (value) {
                                        log("is remember me :-->> $value");
                                        controller.toggleRememberMe(
                                          val: value,
                                        );
                                      },
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          Dimens.four,
                                        ),
                                        side: BorderSide(
                                          color: AppColors.checkBoxBorderColor,
                                          width: Dimens.one,
                                        ),
                                      ),
                                      side: BorderSide(
                                        color: AppColors.checkBoxBorderColor,
                                        width: Dimens.one,
                                      ),
                                    ),
                                  ),
                                  Dimens.boxWidth8,
                                  AppText(
                                    text: TranslationKeys.rememberMe.tr,
                                    style: AppStyles.ubBlack14W500,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () =>
                                    RouteManagement.goToForgotPassword(),
                                child: AppText(
                                  text: TranslationKeys.forgotPassword.tr,
                                  style: AppStyles.ubNavyBlue14W600,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          Dimens.boxHeight20,
                          CustomButton(
                            title: TranslationKeys.signIn.tr,
                            backGroundColor: AppColors.navyBlue,
                            onTap: () {
                              controller.onClickOnLogin();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (controller.loginType == StringConstants.customer)
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Divider(
                                height: Dimens.one,
                                color: AppColors.hintColor,
                              ),
                            ),
                            Dimens.boxWidth4,
                            AppText(
                              text: TranslationKeys.orLoginWith.tr,
                              style: AppStyles.ubHintColor14W600,
                              maxLines: 1,
                            ),
                            Dimens.boxWidth4,
                            Expanded(
                              child: Divider(
                                height: Dimens.one,
                                color: AppColors.hintColor,
                              ),
                            ),
                          ],
                        ),
                        Dimens.boxHeight24,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.iconsFacebook,
                              alignment: Alignment.center,
                              height: Dimens.fiftyThree,
                              width: Dimens.fiftyThree,
                            ),
                            Dimens.boxWidth16,
                            SvgPicture.asset(
                              Assets.iconsInstagram,
                              alignment: Alignment.center,
                              height: Dimens.fiftyThree,
                              width: Dimens.fiftyThree,
                            ),
                            Dimens.boxWidth16,
                            SvgPicture.asset(
                              Assets.iconsApple,
                              alignment: Alignment.center,
                              height: Dimens.fiftyThree,
                              width: Dimens.fiftyThree,
                            ),
                          ],
                        ),
                        Dimens.boxHeight24,
                      ],
                    ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: TranslationKeys.doNotHaveAnAccount.tr,
                        style: AppStyles.ubPurple15W500,
                        children: [
                          TextSpan(
                            text: TranslationKeys.registerNow.tr,
                            style: AppStyles.ubNavyBlue15W700,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.focusScope?.unfocus();
                                RouteManagement.goChooseBabySitter();
                              },
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Dimens.boxHeight24,
                ],
              ),
            ),
          ),
        ),
      );
}
