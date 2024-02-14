import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/controllers.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/views/signUp/signup.dart';
import 'package:northshore_nanny_flutter/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/widgets/custom_button.dart';

import '../../../widgets/custom_text_field.dart';

class CreateProfileView extends StatelessWidget {
  CreateProfileView({super.key});
  final selectedInterface = Get.arguments;
  @override
  Widget build(BuildContext context) => GetBuilder<SignupViewController>(
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomAppbarWidget(
            title: TranslationKeys.createProfile.tr,
            toUpperCaseTitle: false,
          ),
          bottomSheet: Container(
            color: Colors.white,
            padding: Dimens.edgeInsetsL16R16B16,
            child: CustomButton(
              title: TranslationKeys.continueWord.tr,
              backGroundColor: AppColors.navyBlue,
              onTap: () {
                Get.to( ChildProfileView(), arguments: selectedInterface);
              },
            ),
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: Dimens.edgeInsets16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    fit: StackFit.loose,
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: Dimens.oneHundredTwenty,
                          width: Dimens.oneHundredTwenty,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimens.twenty),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.greyColor.withOpacity(0.1),
                                blurRadius: Dimens.ten,
                                blurStyle: BlurStyle.normal,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        Assets.iconsProfile,
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                        top: -10,
                        right: Dimens.eightyThree,
                        child: SvgPicture.asset(
                          Assets.iconsUpload,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  Dimens.boxHeight10,
                  AppText(
                    text:
                        '${TranslationKeys.profilePicture.tr} (${TranslationKeys.optional.tr})'
                            .tr,
                    style: AppStyles.ubGrey15W500,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Dimens.boxHeight26,
                  TextField(
                    controller: controller.firstNameTextEditingController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: customFieldDeco(
                      hintText: TranslationKeys.firstName.tr,
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsSmallProfile,
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
                  Dimens.boxHeight20,
                  TextField(
                    controller: controller.lastNameTextEditingController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: customFieldDeco(
                      hintText: TranslationKeys.lastName.tr,
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsSmallProfile,
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
                  Dimens.boxHeight20,
                  TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: controller.phoneNumberTextEditingController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: customFieldDeco(
                      hintText: '000 000 0000',
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsPhone,
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
                  Dimens.boxHeight20,
                  TextField(
                    controller: controller.locationTextEditingController,
                    maxLines: 1,
                    minLines: 1,
                    decoration: customFieldDeco(
                      hintText: TranslationKeys.selectLocation.tr,
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsLocationDot,
                          height: Dimens.ten,
                          width: Dimens.ten,
                        ),
                      ),
                      suffix: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsLocation,
                          height: Dimens.ten,
                          width: Dimens.ten,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.navyBlue,
                    cursorWidth: Dimens.one,
                    style: AppStyles.ubBlack15W600,
                    keyboardType: TextInputType.text,
                  ),
                  Dimens.boxHeight20,
                  DropdownButtonFormField(
                    items: [
                      DropdownMenuItem<String>(
                        value: TranslationKeys.male.tr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: TranslationKeys.male.tr,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: TranslationKeys.female.tr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: TranslationKeys.female.tr,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      // controller.selectedGender = value;
                    },
                    icon: SvgPicture.asset(
                      Assets.iconsDownArrow,
                    ),
                    iconSize: Dimens.ten,
                    borderRadius: BorderRadius.circular(
                      Dimens.eight,
                    ),
                    isExpanded: true,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(Assets.iconsGender),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightNavyBlue,
                          width: Dimens.one,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimens.eight,
                        ),
                      ),
                      hintMaxLines: 1,
                      contentPadding: Dimens.edgeInsets16,
                      hintText:
                          '${TranslationKeys.gender.tr} (${TranslationKeys.optional.tr})',
                      hintStyle: AppStyles.ubHintColor15W500,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightNavyBlue,
                          width: Dimens.one,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimens.eight,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightNavyBlue,
                          width: Dimens.one,
                        ),
                        borderRadius: BorderRadius.circular(
                          Dimens.eight,
                        ),
                      ),
                    ),
                    menuMaxHeight: Dimens.hundred,
                    alignment: Alignment.bottomCenter,
                  ),
                  Dimens.boxHeight20,
                ],
              ),
            ),
          ),
        ),
      );
}
