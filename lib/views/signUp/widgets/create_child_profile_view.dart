import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/widgets/widgets.dart';

import '../../../controllers/signUp/signup_controller.dart';

class CreateChildProfileView extends StatelessWidget {
  const CreateChildProfileView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<SignupViewController>(
        builder: (controller) => Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.createChildProfile.tr,
            toUpperCaseTitle: false,
            actions: [
              Padding(
                padding: Dimens.edgeInsetsR16,
                child: InkWell(
                  onTap: () {},
                  child: AppText(
                    text: TranslationKeys.skip.tr,
                    maxLines: 1,
                    style: AppStyles.ubGrey16W500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
            bottom: LinearProgressIndicator(
              backgroundColor: AppColors.lightNavyBlue,
              value: 0.4,
              minHeight: Dimens.four,
              color: AppColors.navyBlue,
            ),
            bottomHeight: Dimens.four,
            bottomWidth: Get.width,
          ),
          bottomSheet: Container(
            color: AppColors.primaryColor,
            padding: Dimens.edgeInsetsL16R16B16,
            child: CustomButton(
              title: TranslationKeys.continueWord.tr,
              backGroundColor: AppColors.navyBlue,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: Dimens.edgeInsetsL16R16B16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Dimens.boxHeight24,
                    TextField(
                      controller: controller.childNameTextEditingController,
                      maxLines: 1,
                      minLines: 1,
                      decoration: customFieldDeco(
                        hintText:
                            '${TranslationKeys.nameOfChild.tr} (${TranslationKeys.optional.tr})',
                        prefixWidget: Padding(
                          padding: Dimens.edgeInsets12,
                          child: SvgPicture.asset(
                            Assets.iconsUserTag,
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
                      controller: controller.childAgeTextEditingController,
                      maxLines: 1,
                      minLines: 1,
                      decoration: customFieldDeco(
                        hintText:
                            '${TranslationKeys.ageOfChild.tr} (${TranslationKeys.optional.tr})',
                        prefixWidget: Padding(
                          padding: Dimens.edgeInsets12,
                          child: SvgPicture.asset(
                            Assets.iconsCake,
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
                      onChanged: (value) {},
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
                    TextField(
                      controller: controller.allergiesTextEditingController,
                      maxLines: 1,
                      minLines: 1,
                      decoration: customFieldDeco(
                        hintText:
                            '${TranslationKeys.allergiesDietaryRestriction.tr} (${TranslationKeys.optional.tr})',
                        prefixWidget: Padding(
                          padding: Dimens.edgeInsets12,
                          child: SvgPicture.asset(
                            Assets.iconsSadEmoji,
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
                      controller:
                          controller.medicalConditionTextEditingController,
                      maxLines: 1,
                      minLines: 1,
                      decoration: customFieldDeco(
                        hintText:
                            '${TranslationKeys.medicalCondition.tr} (${TranslationKeys.optional.tr})',
                        prefixWidget: Padding(
                          padding: Dimens.edgeInsets12,
                          child: SvgPicture.asset(
                            Assets.iconsBrifecaseCross,
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
                    SizedBox(
                      height: Dimens.eightySix,
                      child: TextField(
                        controller: controller.anyThingTextEditingController,
                        maxLines: 4,
                        minLines: 4,
                        textAlign: TextAlign.start,
                        decoration: customFieldDeco(
                          hintText:
                              '${TranslationKeys.anythingElse.tr} (${TranslationKeys.optional.tr})',
                          prefixWidget: Padding(
                            padding: Dimens.edgeInsets12,
                            child: SvgPicture.asset(
                              Assets.iconsTaskSquare,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
