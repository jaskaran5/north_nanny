import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/controllers/forgot_password/forgot_password_controller.dart';
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

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: TranslationKeys.forgotPassword.tr,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.pdSemiBoldBlack24,
                  ),
                  Dimens.boxHeight16,
                  AppText(
                    text: TranslationKeys.doNotWorryEnterEmail.tr,
                    style: AppStyles.ubGrey16W400,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Dimens.boxHeight24,
                  TextField(
                    controller: controller.emailTextEditingController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: customFieldDeco(
                      hintText: TranslationKeys.enterEmail.tr,
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets10,
                        child: SvgPicture.asset(
                          Assets.iconsEmail,
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
                  Dimens.boxHeight24,
                  CustomButton(
                    title: TranslationKeys.sendCode.tr,
                    backGroundColor: AppColors.navyBlue,
                    onTap: () {
                      RouteManagement.goToEmailVerification();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
