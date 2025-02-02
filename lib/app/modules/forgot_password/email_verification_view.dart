import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) => Scaffold(
          appBar: const CustomAppbarWidget(),
          body: GestureDetector(
            onTap: () {
              Get.focusScope?.unfocus();
            },
            child: Padding(
              padding: Dimens.edgeInsets16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimens.boxHeight16,
                  AppText(
                    text: TranslationKeys.emailOtpVerification.tr,
                    style: AppStyles.pdSemiBoldBlack24,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Dimens.boxHeight16,
                  Flexible(
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: TranslationKeys.enterTheCode.tr,
                        style: AppStyles.ubGrey16W400,
                        children: [
                          TextSpan(
                            text: '${TranslationKeys.email.tr} ',
                            style: AppStyles.ubBlack16W600,
                          ),
                          TextSpan(
                            text: TranslationKeys.toResetPassword.tr,
                            style: AppStyles.ubGrey16W400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Dimens.boxHeight24,
                  PinCodeTextField(
                    appContext: Get.context!,
                    length: controller.otpLength,
                    keyboardType: TextInputType.phone,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    cursorColor: AppColors.navyBlue,
                    cursorWidth: Dimens.one,
                    autoDismissKeyboard: true,
                    autoDisposeControllers: false,
                    textInputAction: TextInputAction.next,
                    controller: controller.otpTextEditingController,
                    textStyle: AppStyles.ubBlack18W600,
                    pinTheme: PinTheme(
                      borderRadius: BorderRadius.circular(
                        Dimens.eight,
                      ),
                      borderWidth: Dimens.one,
                      fieldHeight: Dimens.fiftyThree,
                      fieldWidth: Dimens.fiftyThree,
                      activeColor: AppColors.lightNavyBlue,
                      activeBorderWidth: Dimens.one,
                      selectedColor: AppColors.activeBorderColor,
                      activeFillColor: Colors.transparent,
                      inactiveColor: AppColors.lightNavyBlue,
                      inactiveBorderWidth: Dimens.one,
                      shape: PinCodeFieldShape.box,
                    ),
                  ),
                  Dimens.boxHeight16,
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: '${TranslationKeys.didNotReceiveOtp.tr} ',
                      style: AppStyles.ubGrey15W500,
                      children: [
                        TextSpan(
                          text: TranslationKeys.reSendOtp.tr,
                          style: AppStyles.ubNavyBlue15W700,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.postOtpApi(isComeFromResend: true);
                            },
                        ),
                      ],
                    ),
                  ),
                  Dimens.boxHeight24,
                  CustomButton(
                    title: TranslationKeys.submit.tr,
                    backGroundColor: AppColors.navyBlue,
                    onTap: () {
                      controller.otpValidator();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
