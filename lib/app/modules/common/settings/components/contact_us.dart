import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_text_field.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      init: SettingController(),
      builder: (controller) {
        return Scaffold(
          appBar: const CustomAppbarWidget(),
          body: Center(
            child: Padding(
              padding: Dimens.edgeInsets16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: "Contact us",
                    style: AppStyles.pdSemiBoldBlack24,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: Get.height * .1,
                  ),
             //======//
                  /** Email  */
                  TextField(
                    controller: controller.emailTextEditingController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: customFieldDeco(
                      hintText: TranslationKeys.emailE.tr,
                      hintStyle: AppStyles.ubHintColor15W500,
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsEmail,
                          height: Dimens.twentyFour,
                          width: Dimens.twentyFour,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.blackColor,
                    cursorWidth: Dimens.one,
                    style: AppStyles.ubBlack15W600,
                  ),
                  const SizedBox(height: 20),
                  /** SUBJECT */
                  TextField(
                    controller: controller.subjectTextEditingController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: customFieldDeco(
                      hintStyle: AppStyles.ubHintColor15W500,
                      hintText: TranslationKeys.subject.tr,
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsDocumentText,
                          height: Dimens.twentyFour,
                          width: Dimens.twentyFour,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.blackColor,
                    cursorWidth: Dimens.one,
                    style: AppStyles.ubBlack15W600,
                  ),
                  const SizedBox(height: 20),

                  /** MESSAGE */
                  TextField(
                    keyboardType: TextInputType.multiline,
                    controller: controller.messageTextEditingController,


                    maxLines: null,
                    minLines: 3,
                    decoration: customFieldDeco(
                      hintStyle: AppStyles.ubHintColor15W500,
                      hintText: TranslationKeys.message.tr,
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets0.copyWith(bottom: Dimens.thirtyFive),
                        child: SvgPicture.asset(
                          Assets.iconsAboutUs,
                          height: Dimens.twentyFour,
                          width: Dimens.twentyFour,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.blackColor,
                    cursorWidth: Dimens.one,
                    style: AppStyles.ubBlack15W600,
                  ),
                  const Spacer(),

                  /** SUBMIT BUTTON */

                  CustomButton(
                    title: TranslationKeys.submit.tr,
                    textColor: Colors.white,
                    backGroundColor: AppColors.navyBlue,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
