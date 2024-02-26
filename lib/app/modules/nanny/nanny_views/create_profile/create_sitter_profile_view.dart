import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/create_profile/create_sitter_profile_controller.dart';
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
import '../../../../widgets/custom_cache_network_image.dart';
import '../services/services_view.dart';

class CreateNannyProfileView extends StatelessWidget {
  const CreateNannyProfileView({super.key});

  @override
  Widget build(BuildContext context) =>
      GetBuilder<CreateSitterProfileController>(
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomAppbarWidget(
            backgroundColor: Colors.white,
            title: TranslationKeys.createProfile.tr,
            toUpperCaseTitle: false,
          ),
          body: GestureDetector(
            onTap: () {
              Get.focusScope?.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: Dimens.edgeInsets16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.passthrough,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: Dimens.oneHundredTwenty,
                            width: Dimens.oneHundredTwenty,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(Dimens.twenty),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: Dimens.three,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                  AppColors.lightNavyBlue.withOpacity(.8),
                                  blurRadius: Dimens.five,
                                )
                              ],
                            ),
                            child: controller.imageUrl?.isEmpty==true
                                ? Padding(
                              padding: Dimens.edgeInsets16,
                              child: SvgPicture.asset(
                                Assets.iconsProfile,
                                fit: BoxFit.contain,
                              ),
                            )
                                : CustomCacheNetworkImage(
                              img: controller.imageUrl.toString(),
                              size: Dimens.oneHundredTwenty,
                              imageRadius: Dimens.eighteen,
                              imageShape: BoxShape.rectangle,
                            ),
                          ),
                          Positioned(
                            top: -20,
                            right: -30,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimens.ten),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    AppColors.greyColor.withOpacity(0.05),
                                    blurRadius: Dimens.fourteen,
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset(
                                Assets.iconsUpload,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      controller: controller.ageTextEditingController,
                      maxLines: 1,
                      minLines: 1,
                      decoration: customFieldDeco(
                        hintText: TranslationKeys.age.tr,
                        prefixWidget: Padding(
                          padding: Dimens.edgeInsets12,
                          child: SvgPicture.asset(
                            Assets.iconsCake,
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
                      keyboardType: TextInputType.phone,
                    ),
                    Dimens.boxHeight20,
                    AppDropdown(
                      selectedItem: controller.selectedGender?.isEmpty == true
                          ? '${TranslationKeys.gender.tr} (${TranslationKeys.optional.tr})'
                          : controller.selectedGender,
                      onChanged: (value) {
                        controller.selectedGender = value.toString();
                        controller.update();
                      },
                      baseTextStyle: controller.selectedGender?.isEmpty == true
                          ? AppStyles.ubHintColor15W500
                          : AppStyles.ubNavyBlue15W600,
                      prefix: SvgPicture.asset(Assets.iconsGender),
                      items: controller.genderList,
                      itemBuilder: (context, item, isSelected) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: Dimens.edgeInsetsH20V15,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: item.toString().tr,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: AppStyles.ubNavyBlue15W600,
                                  ),
                                  item == controller.selectedGender
                                      ? SvgPicture.asset(Assets.iconsCircleTick)
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
                    AppDropdown(
                      selectedItem: controller.selectedYear?.isEmpty == true
                          ? TranslationKeys.experience.tr
                          : controller.selectedYear,
                      onChanged: (value) {
                        controller.selectedYear = value.toString();
                        controller.update();
                      },
                      baseTextStyle: controller.selectedYear?.isEmpty == true
                          ? AppStyles.ubHintColor15W500
                          : AppStyles.ubNavyBlue15W600,
                      prefix: SvgPicture.asset(Assets.iconsBrifecaseCross),
                      items: controller.experienceList,
                      itemBuilder: (context, item, isSelected) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: Dimens.edgeInsetsH20V15,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: item.toString().tr,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: AppStyles.ubNavyBlue15W600,
                                  ),
                                  item == controller.selectedYear
                                      ? SvgPicture.asset(Assets.iconsCircleTick)
                                      : Dimens.box0,
                                ],
                              ),
                            ),
                            item != controller.experienceList.last
                                ? Dimens.boxHeight2
                                : Dimens.box0,
                            item != controller.experienceList.last
                                ? Divider(
                                    color: AppColors.dividerColor,
                                    height: Dimens.two,
                                  )
                                : Dimens.box0,
                          ],
                        );
                      },
                      maxHeight: Dimens.twoHundred,
                      itemBuilderPhysics: const ScrollPhysics(),
                    ),
                    Dimens.boxHeight20,
                    TextField(
                      controller: controller.highSchoolTextEditingController,
                      maxLines: 1,
                      minLines: 1,
                      decoration: customFieldDeco(
                        hintText: TranslationKeys.nameOfSchool.tr,
                        prefixWidget: Padding(
                          padding: Dimens.edgeInsets12,
                          child: SvgPicture.asset(
                            Assets.iconsHouse,
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
                      controller: controller.collegeTextEditingController,
                      maxLines: 1,
                      minLines: 1,
                      decoration: customFieldDeco(
                        hintText: TranslationKeys.nameOfCollege.tr,
                        prefixWidget: Padding(
                          padding: Dimens.edgeInsets12,
                          child: SvgPicture.asset(
                            Assets.iconsBuilding,
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
                    AppDropdown(
                      selectedItem: controller.licenseHaveOrNot?.isEmpty == true
                          ? TranslationKeys.driverLicense.tr
                          : controller.licenseHaveOrNot,
                      onChanged: (value) {
                        controller.licenseHaveOrNot = value.toString();
                        controller.update();
                      },
                      baseTextStyle:
                          controller.licenseHaveOrNot?.isEmpty == true
                              ? AppStyles.ubHintColor15W500
                              : AppStyles.ubNavyBlue15W600,
                      prefix: SvgPicture.asset(Assets.iconsPersonalcard),
                      items: controller.licenseList,
                      itemBuilder: (context, item, isSelected) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: Dimens.edgeInsetsH20V15,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: item.toString().tr,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: AppStyles.ubNavyBlue15W600,
                                  ),
                                  controller.licenseHaveOrNot == item.toString()
                                      ? SvgPicture.asset(Assets.iconsCircleTick)
                                      : Dimens.box0,
                                ],
                              ),
                            ),
                            item != controller.licenseList.last
                                ? Dimens.boxHeight2
                                : Dimens.box0,
                            item != controller.licenseList.last
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
                      controller: controller.tellUsTextEditingController,
                      maxLines: 4,
                      decoration: customFieldDeco(
                        hintText: TranslationKeys.tellUsAboutYourSelf.tr,
                        prefixWidget: Padding(
                          padding: Dimens.edgeInsetsB55,
                          child: SvgPicture.asset(
                            Assets.iconsDocumentText,
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
                    Dimens.boxHeight20,
                    CustomButton(
                      title: TranslationKeys.continueWord.tr,
                      backGroundColor: AppColors.navyBlue,
                      onTap: () {
                        Get.to(const ServicesView(),);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
