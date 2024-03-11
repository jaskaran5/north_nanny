import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/auth/customer/customer_views/create_child_profile/create_child_profile_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_drop_down.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_text_field.dart';

class CreateChildProfileView extends StatelessWidget {
  const CreateChildProfileView({super.key});
  @override
  Widget build(BuildContext context) =>
      GetBuilder<CreateChildProfileController>(
        builder: (controller) => Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: CustomAppbarWidget(
              title: TranslationKeys.createChildProfile.tr,
              appBarHeight: Dimens.oneHundredTwenty,
              toUpperCaseTitle: false,
              actions: [
                Padding(
                  padding: Dimens.edgeInsetsT16R16,
                  child: GestureDetector(
                    onTap: () {
                      controller.skipChildApi();
                    },
                    child: AppText(
                      text: TranslationKeys.skip.tr,
                      maxLines: 1,
                      style: AppStyles.ubGrey16W500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],

              /** LINEAR INDICATOR */
              bottom: LinearProgressIndicator(
                backgroundColor: AppColors.lightNavyBlue,
                value: controller.linearIndicatorValue.value,
                minHeight: Dimens.three,
                color: AppColors.navyBlue,
              ),
              bottomHeight: Dimens.three,
              bottomWidth: Get.width,
            ),
            floatingActionButton: Container(
              color: AppColors.primaryColor,
              padding: Dimens.edgeInsetsL16R16B20,
              child: CustomButton(
                title: TranslationKeys.continueWord.tr,
                backGroundColor: AppColors.navyBlue,
                onTap: () {
                  controller.addChildValidation(context);

                  // print(controller.currentIndex);
                  // RouteManagement.goToOffAllHome(selectedInterface);
                  // RouteManagement.goToOffAllDashboard(isFromSetting: false);
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            // bottomSheet:

            //  Container(
            //   color: AppColors.primaryColor,
            //   padding: Dimens.edgeInsetsL16R16B20,
            //   child: CustomButton(
            //     title: TranslationKeys.continueWord.tr,
            //     backGroundColor: AppColors.navyBlue,
            //     onTap: () {
            //       controller.addChildValidation(context);

            //       // print(controller.currentIndex);
            //       // RouteManagement.goToOffAllHome(selectedInterface);
            //       // RouteManagement.goToOffAllDashboard(isFromSetting: false);
            //     },
            //   ),
            // ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  for (var i = 1; i <= controller.noOfChild.value; i++)
                    i == controller.currentIndex.value
                        ? GestureDetector(
                            onTap: () {
                              Get.focusScope?.unfocus();
                            },
                            child: Padding(
                              padding: Dimens.edgeInsetsL16R16B16,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Dimens.boxHeight32,
                                  TextField(
                                    maxLength: 20,
                                    controller: controller
                                        .childNameTextEditingController,
                                    maxLines: 1,
                                    minLines: 1,
                                    decoration: customFieldDeco(
                                      hintText: TranslationKeys.nameOfChild.tr,
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
                                    maxLength: 2,
                                    controller: controller
                                        .childAgeTextEditingController,
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
                                  AppDropdown(
                                    selectedItem: controller
                                                .selectedGender?.isEmpty ==
                                            true
                                        ? '${TranslationKeys.gender.tr} (${TranslationKeys.optional.tr})'
                                        : controller.selectedGender,
                                    onChanged: (value) {
                                      controller
                                          .setGenderValue(value.toString());
                                    },
                                    baseTextStyle:
                                        controller.selectedGender?.isEmpty ==
                                                true
                                            ? AppStyles.ubHintColor15W500
                                            : null,
                                    prefix:
                                        SvgPicture.asset(Assets.iconsGender),
                                    items: controller.genderList,
                                    itemBuilder: (context, item, isSelected) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: Dimens.edgeInsetsH20V15,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppText(
                                                  text: item.toString().tr,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                  style: AppStyles
                                                      .ubNavyBlue15W600,
                                                ),
                                                item ==
                                                        controller
                                                            .selectedGender
                                                    ? SvgPicture.asset(
                                                        Assets.iconsCircleTick)
                                                    : Dimens.box0,
                                              ],
                                            ),
                                          ),
                                          item != controller.genderList.last
                                              ? Dimens.boxHeight2
                                              : Dimens.box0,
                                          item != controller.genderList.last
                                              ? Divider(
                                                  color: AppColors.dividerColor,
                                                  height: Dimens.two,
                                                )
                                              : Dimens.box0,
                                        ],
                                      );
                                    },
                                  ),
                                  Dimens.boxHeight20,
                                  TextField(
                                    controller: controller
                                        .allergiesTextEditingController,
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
                                    controller: controller
                                        .medicalConditionTextEditingController,
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
                                  TextField(
                                    controller: controller
                                        .anyThingTextEditingController,
                                    maxLines: 4,
                                    textAlign: TextAlign.start,
                                    decoration: customFieldDeco(
                                      hintText:
                                          '${TranslationKeys.anythingElse.tr} (${TranslationKeys.optional.tr})',
                                      prefixWidget: Padding(
                                        padding: Dimens.edgeInsetsB55,
                                        child: SvgPicture.asset(
                                          Assets.iconsTaskSquare,
                                          height: Dimens.eighteen,
                                          width: Dimens.eighteen,
                                          alignment: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
                                    cursorColor: AppColors.navyBlue,
                                    cursorWidth: Dimens.one,
                                    style: AppStyles.ubBlack15W600,
                                    keyboardType: TextInputType.text,
                                  ),
                                  Dimens.boxHeight100,
                                ],
                              ),
                            ),
                          )
                        : const SizedBox()
                ],
              ),
            )),
      );
}
