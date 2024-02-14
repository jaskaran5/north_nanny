import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/sitter_controllers/create_profile/create_sitter_profile.dart';

import '../../../res/res.dart';
import '../../../utils/translations/translation_keys.dart';
import '../../../widgets/widgets.dart';
import '../services/services_view.dart';

class CreateSitterProfileView extends StatelessWidget {
  CreateSitterProfileView({super.key});
  final selectedInterface = Get.arguments;

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
          body: SingleChildScrollView(
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
                              text: TranslationKeys.male.tr.capitalizeFirst,
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
                              text: TranslationKeys.female.tr.capitalizeFirst,
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
                    items: List.generate(
                      controller.experienceList.length,
                      (index) => DropdownMenuItem<String>(
                        value: controller.experienceList[index].tr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: controller
                                  .experienceList[index].tr.capitalizeFirst,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
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
                        child: SvgPicture.asset(Assets.iconsBrifecaseCross),
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
                      hintText: TranslationKeys.experience.tr,
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
                  DropdownButtonFormField(
                    items: List.generate(
                      controller.licenseList.length,
                      (index) => DropdownMenuItem<String>(
                        value: controller.licenseList[index].tr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: controller.licenseList[index].tr,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
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
                        child: SvgPicture.asset(Assets.iconsPersonalcard),
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
                      hintText: TranslationKeys.driverLicense.tr,
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
                    controller: controller.tellUsTextEditingController,
                    maxLines: 4,
                    minLines: 3,
                    decoration: customFieldDeco(
                      hintText: TranslationKeys.tellUsAboutYourSelf.tr,
                      prefixWidget: Padding(
                        padding: Dimens.edgeInsets12,
                        child: SvgPicture.asset(
                          Assets.iconsDocumentText,
                          height: Dimens.ten,
                          width: Dimens.ten,
                          alignment: Alignment.topLeft,
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
                      Get.to(ServicesView(), arguments: selectedInterface);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
