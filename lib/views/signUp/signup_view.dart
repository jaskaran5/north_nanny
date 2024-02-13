import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/controllers.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/utils/navigators/navigators.dart';
import 'package:northshore_nanny_flutter/views/signUp/signup.dart';
import 'package:northshore_nanny_flutter/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/widgets/custom_text_field.dart';

import '../../utils/utils.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) =>
      GetBuilder<SignupViewController>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          resizeToAvoidBottomInset: false,
          appBar: const CustomAppbarWidget(),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          AppText(
                            text: TranslationKeys.helloRegistration.tr,
                            style: AppStyles.pdSemiBoldBlack24,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                          ),
                          Dimens.boxHeight10,
                          AppText(
                            text: TranslationKeys.creatingAnAccount.tr,
                            style: AppStyles.ubGrey16W400,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Dimens.boxHeight32,
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
                          TextField(
                            controller:
                                controller.passwordTextEditingController,
                            maxLines: 1,
                            minLines: 1,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.enterPassword.tr,
                              suffix: Padding(
                                padding: Dimens.edgeInsets12,
                                child: SvgPicture.asset(
                                  Assets.iconsShowPassword,
                                  height: Dimens.ten,
                                  width: Dimens.ten,
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
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            style: AppStyles.ubBlack15W600,
                            cursorColor: AppColors.blackColor,
                            cursorWidth: Dimens.one,
                          ),
                          Dimens.boxHeight16,
                          TextField(
                            controller:
                                controller.confirmPasswordTextEditingController,
                            maxLines: 1,
                            minLines: 1,
                            decoration: customFieldDeco(
                              hintText: TranslationKeys.confirmPassword.tr,
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
                            keyboardType: TextInputType.text,
                          ),
                          Dimens.boxHeight16,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Dimens.twenty,
                                width: Dimens.twenty,
                                child: Checkbox(
                                  value: controller.isBoxChecked,
                                  activeColor: AppColors.navyBlue,
                                  onChanged: (value) {},
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
                              Flexible(
                                child: Padding(
                                  padding: Dimens.edgeInsetsT10,
                                  child: RichText(
                                    text: TextSpan(
                                      text: TranslationKeys.bySignUp.tr,
                                      style: AppStyles.ubGrey14W500,
                                      children: [
                                        TextSpan(
                                          text: TranslationKeys
                                              .termAndConditions.tr,
                                          style: AppStyles.ubNavyBlue14W700,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                        ),
                                        TextSpan(
                                          text: ' ${TranslationKeys.and}  '.tr,
                                          style: AppStyles.ubGrey14W500,
                                        ),
                                        TextSpan(
                                          text:
                                              TranslationKeys.privacyPolicy.tr,
                                          style: AppStyles.ubNavyBlue14W700,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                        ),
                                      ],
                                    ),
                                    maxLines: 2,
                                    softWrap: true,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Dimens.boxHeight32,
                          CustomButton(
                            title: TranslationKeys.register.tr,
                            backGroundColor: AppColors.navyBlue,
                            onTap: () {
                              Get.focusScope?.unfocus();
                              Get.to(const CreateProfileView());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: TranslationKeys.alreadyHaveAccount.tr,
                        style: AppStyles.ubGrey15W500,
                        children: [
                          TextSpan(
                            text: TranslationKeys.signIn.tr,
                            style: AppStyles.ubNavyBlue15W700,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.focusScope?.unfocus();
                                RouteManagement.goToLogIn();
                              },
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Dimens.boxHeight16,
                ],
              ),
            ),
          ),
        );
      });
}
